#!/bin/bash -x 

export WORKDIR=~/workspace/hgrm/master
export MIRROR=~/workspace/hgrm/mirror
export BRANCH=pf/hgrm/master            # hagoromo の時

export BUILD_TYPE=release

export SODIR=out/target/product/pf-sc_product/system/lib
export BINDIR=out/target/product/pf-sc_product/system/bin
export INSTALL_LIBS="libSoundService.so libSoundServiceFw.so libSoundServiceSettings.so"
export INSTALL_BINS="SsSocketSample SoundServiceSample EffectCtrlSample"

# MACHINE/DISTRO/IMAGE レシピを別のものに切り替える場合は該当箇所を適宜読み替えてください。outディレクトリは作り直されるため消す必要はありません。
# MACHINEをsony-habb, DISTROをsony-sc, IMAGEをsony-image-sc-release とした参考例です。

# install firmware
cd $WORKDIR/hagoromo
cd $SODIR
for file in $INSTALL_LIBS
do
    echo $file
    adb push $file /system/vendor/sony/lib
done
cd $WORKDIR/hagoromo
cd $BINDIR
for file in $INSTALL_BINS
do
    echo $file
    adb push $file /system/vendor/sony/bin
    adb shell chmod 0755 /system/vendor/sony/bin/$file
done

adb shell sync
adb shell sync
adb shell sync
adb shell systemctl restart hagoromo-soundpostcontrol.service
#MACHINE=sony-habb DISTRO=sony-sc IMAGE=sony-image-sc-release ./build.sh
#MACHINE=sony-habb DISTRO=sony-sc IMAGE=sony-image-sc ./build.sh
#MACHINE=sony-pf-habb DISTRO=sony-pf-sc IMAGE=sony-image-pf-sc ./build.sh
#(sleep 30; adb shell reboot) &
#./install.sh

# 初回のみEULAが表示され、[Press space to continue, ‘q’ to quit.] が出るので、space key を押して読み進めてください。
# Do you accept the EULA you just read? ⇒ 内容を確認して問題なければ y

# EULA=1 を指定することでEULAの表示がパスできます。内容を確認済みの方はご活用ください。
# EULA=1 MACHINE=sony-habb DISTRO=sony-sc IMAGE=sony-image-sc-release ./build.sh

# ビルド成果物は、out_${MACHINE}_${DISTRO} ディレクトリに生成されます

# notify user
notify-send -t 30000 "install ebisu complete!!!"
#curl 'https://api.simplepush.io/send/nc44M6/install complete/install ebisu image complete!!!'
