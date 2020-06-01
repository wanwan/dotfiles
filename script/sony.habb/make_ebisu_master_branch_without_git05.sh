#!/bin/bash -x 

# ワークスペースを ~/workspace/hgrm/master , reference を ~/workspace/hgrm/mirror とした参考例です
 
export WORKDIR=~/workspace/hgrm/master
export MIRROR=~/workspace/hgrm/mirror
export BRANCH=pf/hgrm/master            # hagoromo の時
mkdir -p $WORKDIR
cd $WORKDIR
repo init -g default,-no-github -u ssh://github.com/route384/hgrm.bsp.manifest -m ebisu_only.xml -b $BRANCH --reference=$MIRROR
 
time repo sync -j8
repo start --all $BRANCH


