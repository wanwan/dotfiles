#!/bin/bash

export WORKDIR=~/workspace/hgrm/master
export MIRROR=~/workspace/hgrm/mirror
export BRANCH=pf/hgrm/master            # hagoromo の時

export BUILD_TYPE=release

cd $WORKDIR

CHECK_DIR=()
TAGS=()

# hgrm.device.pf_stationary.audiohal
TAG=hagoromo/device/pf_stationary/audiohal
DIR=$WORKDIR/$TAG
TAGS=("${TAGS[@]}" $TAG)
CHECK_DIR=("${CHECK_DIR[@]}" $DIR)

# hgrm.effectors.izumo-hgrm
TAG=hagoromo/external/effectors_izumo-hgrm
DIR=$WORKDIR/$TAG
TAGS=("${TAGS[@]}" $TAG)
CHECK_DIR=("${CHECK_DIR[@]}" $DIR)

# hgrm.opt.ssoptionalfuncizm
TAG=hagoromo/opt/ssoptionalfuncizm
DIR=$WORKDIR/$TAG
TAGS=("${TAGS[@]}" $TAG)
CHECK_DIR=("${CHECK_DIR[@]}" $DIR)

# hgrm.device.common.audiohal
TAG=hagoromo/device/common/audiohal
DIR=$WORKDIR/$TAG
TAGS=("${TAGS[@]}" $TAG)
CHECK_DIR=("${CHECK_DIR[@]}" $DIR)

# hgrm.hardware.hal.audio
TAG=hagoromo/hardware/hal/audio/include
DIR=$WORKDIR/$TAG
TAGS=("${TAGS[@]}" $TAG)
CHECK_DIR=("${CHECK_DIR[@]}" $DIR)

# hgrm.services.soundpostcontrolservice
TAG=hagoromo/services/soundpostcontrolservice
DIR=$WORKDIR/$TAG
TAGS=("${TAGS[@]}" $TAG)
CHECK_DIR=("${CHECK_DIR[@]}" $DIR)

# hgrm.services.spdifplayerservice
TAG=hagoromo/services/spdifplayerservice
DIR=$WORKDIR/$TAG
TAGS=("${TAGS[@]}" $TAG)
CHECK_DIR=("${CHECK_DIR[@]}" $DIR)


# hgrm.services.dcacservice
#CHECK_DIR=

FIRST_TAG=$1
SECOND_TAG=$2

for dir in ${CHECK_DIR[@]}	  
do
    echo $dir
    cd $dir; git log $FIRST_TAG $SECOND_TAG
done


﻿
