#!/bin/sh
#
# Copyright 2022 NXP

. imx-setup-release.sh $@

BUILD_DIR=.
echo "Adding Integrity layer"
echo "" >> $BUILD_DIR/conf/bblayers.conf
echo "# For Integrity" >> $BUILD_DIR/conf/bblayers.conf
echo "BBLAYERS += \"\${BSPDIR}/sources/meta-imx-integrity\"" >> $BUILD_DIR/conf/bblayers.conf
echo "BBLAYERS += \"\${BSPDIR}/sources/meta-security/meta-integrity\"" >> $BUILD_DIR/conf/bblayers.conf

echo "#IMA-EVM specific" >> $BUILD_DIR/conf/local.conf
echo "DISTRO_FEATURES:append= \" ima\"" >> $BUILD_DIR/conf/local.conf
echo "INHERIT += \"ima-evm-rootfs\"" >> $BUILD_DIR/conf/local.conf
echo "IMA_EVM_BASE = \"\${BSPDIR}/sources/meta-security/meta-integrity\"" >> $BUILD_DIR/conf/local.conf
echo "IMA_EVM_KEY_DIR = \"\${IMA_EVM_BASE}/data/debug-keys\"" >> $BUILD_DIR/conf/local.conf

echo "LAYERSERIES_COMPAT_parsec-layer = \"kirkstone langdale\"" >> $BUILD_DIR/../sources/meta-security/meta-parsec/conf/layer.conf
echo "LAYERSERIES_COMPAT_tpm-layer = \"kirkstone langdale\"" >> $BUILD_DIR/../sources/meta-security/meta-tpm/conf/layer.conf
echo "LAYERSERIES_COMPAT_integrity = \"kirkstone langdale\"" >> $BUILD_DIR/../sources/meta-security/meta-integrity/conf/layer.conf
