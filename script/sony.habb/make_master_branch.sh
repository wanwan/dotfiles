#!/bin/bash -x 

export WORKDIR=~/workspace/hgrm/master
export MIRROR=~/workspace/hgrm/mirror
export BRANCH=pf/hgrm/master
mkdir -p $WORKDIR
cd $WORKDIR
repo init -u ssh://github.com/route384/hgrm.bsp.manifest -b $BRANCH --reference=$MIRROR
repo sync -j64
repo start --all $BRANCH
