#!/bin/sh
 

# mount the /proc /sys /dev filesystems.
/bin/mount -t proc none /proc
/bin/mount -t sysfs none /sys
/bin/mount -t devtmpfs none /dev
/bin/mount -t configfs none /sys/kernel/config

a=`/bin/cat /proc/cmdline`

/bin/mount -n -t securityfs securityfs /sys/kernel/security

# Mounting rootfile system
for word in $a
do
b=`echo $word | grep "root="`
if [ -n "$b" ]; then
    mountdev=`echo $b | cut -d = -f 2`
    echo mountdev=$mountdev
    break;
fi
done

# If mount partition is not given in bootargs, set default mountdev
if ! [ -n "$mountdev" ]; then
	mountdev=/dev/mmcblk0p2
fi

# Sleep 1 sec for probing mmc block device
/bin/sleep 1

# Mounting rootfs with iversion enabled
/bin/mount -o rw,iversion $mountdev /mnt

# ima evm mode: fix or enforce
ima_fix='evm=fix'

if echo $a | /bin/grep -q $ima_fix; then
    echo "Creating keys"
    mkdir -p /mnt/etc/keys
    /bin/keyctl add trusted kmk-trusted "new 32" @u
    /bin/keyctl pipe `keyctl search @u trusted kmk-trusted` >/mnt/etc/keys/kmk-trusted.blob
    /bin/keyctl add encrypted evm-key "new trusted:kmk-trusted 32" @u
    /bin/keyctl pipe `keyctl search @u encrypted evm-key` >/mnt/etc/keys/evm-trusted.blob
	  
   /bin/chmod 1400 /mnt/etc/keys/kmk-trusted.blob
   /bin/chmod 1400 /mnt/etc/keys/evm-trusted.blob
   /bin/chattr =i /mnt/etc/keys/kmk-trusted.blob
   /bin/chattr =i /mnt/etc/keys/evm-trusted.blob
else
    echo "Loading blobs"
    /bin/keyctl add trusted kmk-trusted "load `/bin/cat /mnt/etc/keys/kmk-trusted.blob`" @u > /dev/null
    /bin/keyctl add encrypted evm-key "load `/bin/cat /mnt/etc/keys/evm-trusted.blob`" @u > /dev/null
fi

echo "1" > /sys/kernel/security/evm

if echo $a | /bin/grep -q $ima_fix; then
    echo "Labelling files in fix mode. This will take few minutes. Reboot once done"
    usr/bin/find /mnt/ -type f -exec head -n 1 '{}' >/dev/null \;
    echo "Attributes labeled."
fi
exec /sbin/switch_root /mnt /sbin/init
