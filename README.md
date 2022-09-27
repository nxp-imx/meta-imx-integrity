i.MX Yocto Guide to Build meta-imx-integrity layer
==================================================
meta-imx-integrity layer is used for enabling IMA-EVM feature on i.MX
platforms.
In normal secure boot process, contents of root file system mounted over
persistent storage device are not validated by any mechanism and hence
cannot be trusted. Any malicious changes in non-trusted rootfs contents
are undetected. IMA EVM is the Linux standard mechanism to verify the
integrity of the rootfs. Integrity checks over file attributes and its
contents are performed by Linux IMA EVM module before its execution.
IMA EVM depends on encrypted key loaded on user’s keyring.
Loading keys to root user keyring and enabling EVM is typically done
using initramfs image. The initramfs image is validated using secure boot
process and becomes the part of chain of trust. Initramfs switches control
to main rootfs mounted over storage device, after EVM is successfully
enabled on the system.

Install the `repo` utility
--------------------------

To get the BSP you need to have `repo` installed.

```
$ mkdir ~/bin
$ curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
$ chmod a+x ~/bin/repo
$ PATH=${PATH}:~/bin
```

Download the Yocto Project BSP
------------------------------

```
$ mkdir imx-linux-bsp
$ cd imx-linux-bsp
$ repo init -u https://github.com/nxp-imx/imx-manifest -b imx-linux-kirkstone -m imx-integrity.xml
$ repo sync
```

Create a new build folder
-------------------------


If you want to create a new build folder that includes configuration of
integrity layer:
```
$ MACHINE=<Machine> DISTRO=fsl-imx-xwayland source ./imx-integrity-setup-release.sh -b build-DISTRO
$ source ../sources/imx-build-bamboo/build/hook-in-internal-servers.sh
```
i.MX Machine:
- imx8dxlevk
- imx8mmevk
- imx8mnevk
- imx8mpevk
- imx8mqevk
- imx8qmmek
- imx8ulpevk

Use an existing build folder
----------------------------

If you want to build in an existing build folder:

```
$ cd imx-linux-bsp
$ source setup-environment build
```

Build an image
--------------

```
$ bitbake integrity-image-minimal
```
