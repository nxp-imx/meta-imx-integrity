i.MX Yocto Guide to Build meta-imx-integrity layer
==================================================

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
$ repo init -u https://github.com/nxp-imx/imx-manifest -b imx-linux-nanbield -m imx-integrity.xml
$ repo sync
```

Create a new build folder
-------------------------


If you want to create a new build folder that includes configuration of
integrity layer:
```
$ MACHINE=<Machine> DISTRO=fsl-imx-xwayland source ./imx-integrity-setup-release.sh -b build-DISTRO
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
