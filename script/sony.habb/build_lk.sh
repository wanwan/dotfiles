#!/bin/bash

LKDIR=$HOME/nxp_sdk/sdk/build/cmake

pushd $LKDIR

# Export build environment to the path were the toolchain is installed
export ARMGCC_DIR=/home/waka/toolchain/gcc-linaro-7.3.1-2018.05-x86_64_aarch64-elf
# Build demo application
./clean.sh
./build_pp_cp_debug.sh

popd
