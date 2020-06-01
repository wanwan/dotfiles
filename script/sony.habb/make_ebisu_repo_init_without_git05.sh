#!/bin/bash -x 

# MIRROR=~/workspace/hgrm/mirror を例とします。MIRROR には、任意の新規ディレクトリを指定してください。
  
export MIRROR=~/workspace/hgrm/mirror
mkdir -p $MIRROR
cd $MIRROR
repo init -g default,-no-github -u ssh://github.com/route384/hgrm.bsp.manifest -m ebisu_only.xml -b pf/hgrm/master --mirror
repo sync -j8

