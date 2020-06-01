#!/bin/bash -x 

export MIRROR=~/workspace/hgrm/mirror
mkdir -p $MIRROR
cd $MIRROR
repo init -u ssh://github.com/route384/hgrm.bsp.manifest -b pf/hgrm/master --mirror
repo sync -j4
