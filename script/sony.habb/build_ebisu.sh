#!/bin/bash -x 

source $HOME/bin/functions.sh

export WORKDIR=~/workspace/hgrm/master
export MIRROR=~/workspace/hgrm/mirror
export BRANCH=pf/hgrm/master            # hagoromo の時

export BUILD_TYPE=release

# MACHINE/DISTRO/IMAGE レシピを別のものに切り替える場合は該当箇所を適宜読み替えてください。outディレクトリは作り直されるため消す必要はありません。
# MACHINEをsony-habb, DISTROをsony-sc, IMAGEをsony-image-sc-release とした参考例です。
 
# ビルド
cd $WORKDIR/ebisu-bsp
#MACHINE=sony-habb DISTRO=sony-sc IMAGE=sony-image-sc-release ./build.sh
#MACHINE=sony-habb DISTRO=sony-sc IMAGE=sony-image-sc ./build.sh
MACHINE=sony-pf-habb DISTRO=sony-pf-sc IMAGE=sony-image-pf-sc ./build.sh
 
# 初回のみEULAが表示され、[Press space to continue, ‘q’ to quit.] が出るので、space key を押して読み進めてください。
# Do you accept the EULA you just read? ⇒ 内容を確認して問題なければ y
 
# EULA=1 を指定することでEULAの表示がパスできます。内容を確認済みの方はご活用ください。
# EULA=1 MACHINE=sony-habb DISTRO=sony-sc IMAGE=sony-image-sc-release ./build.sh
 
# ビルド成果物は、out_${MACHINE}_${DISTRO} ディレクトリに生成されます

# notify user
notify-send -t 30000 "build ebisu complete!!!"
notify_phone "build complete" "build ebisu complete"
