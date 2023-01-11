FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://0001-imx_v8_defconfig-IMA-EVM-kernel-config.patch "
SRC_URI:append:mx93-nxp-bsp = "file://0001-imx-v8-defconfig-OPTEE-based-Trusted-key-enablement-.patch "
