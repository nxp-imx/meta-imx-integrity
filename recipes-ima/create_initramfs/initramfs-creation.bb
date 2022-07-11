LICENSE="GPLv3"
LIC_FILES_CHKSUM ="file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
FILES:${PN} += "/init"
FILES:${PN} += "/dev/* ${includedir}"
SRC_URI+= "file://sec_imaevm.sh"

do_install() {
	
	install -d ${D}/
	install -m 777 ${WORKDIR}/sec_imaevm.sh ${D}/init

}
