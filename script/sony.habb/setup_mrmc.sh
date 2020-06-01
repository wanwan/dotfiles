#!/bin/bash -x 

cd 
adb push SoundService.xml /data
adb push workspace/hgrm/master/hagoromo/out_debug/target/product/pf-sc_product/system/bin/SsSocketSample /system/vendor/sony/bin/
adb shell chmod 0755 /system/vendor/sony/bin/SsSocketSample
adb shell sync
adb shell sync
adb shell sync
adb shell reboot
