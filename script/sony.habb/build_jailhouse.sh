#!/bin/bash

JAILHOUSE_PATH=$HOME/nxp_sdk/imx-jailhouse/

pushd $JAILHOUSE_PATH

# Setup environment
export ARCH=arm64
export CROSS_COMPILE=/home/waka/workspace/hgrm/master/ebisu-bsp/sources/meta-sony-hagoromo/meta-sony-bsp/toolchain/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
export KDIR=/home/waka/workspace/hgrm/master/ebisu-bsp/out_sony-habb_sony-sc/tmp/work/sony_habb-poky-linux/linux-imx/4.14.78-r0/linux-imx-4.14.78
# Build jailhouse
make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} KDIR=${KDIR} clean
make ARCH=${ARCH} CROSS_COMPILE=${CROSS_COMPILE} KDIR=${KDIR} all

popd
