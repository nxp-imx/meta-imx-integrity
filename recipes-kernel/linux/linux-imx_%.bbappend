FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://0001-Config-change-required-for-IMA-EVM.patch "
SRC_URI:append:mx93-nxp-bsp = "file://0001-OPTEE-based-Trusted-key-enablement-for-i.MX93.patch "
