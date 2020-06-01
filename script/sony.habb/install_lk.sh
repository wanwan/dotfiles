#!/bin/bash -x

JAILHOUSE_PATH=/home/waka/nxp_sdk/
SDK_PATH=/home/waka/nxp_sdk/

# 一旦 /tmp に転送する場合
pushd $JAILHOUSE_PATH
adb push ./imx-jailhouse/driver/jailhouse.ko /tmp/
adb push ./imx-jailhouse/hypervisor/jailhouse.bin /tmp/
adb push ./imx-jailhouse/configs/arm64/imx8mm.cell /tmp/
adb push ./imx-jailhouse/configs/arm64/imx8mm-lk.cell /tmp/
adb push ./imx-jailhouse/tools/jailhouse /tmp/
adb push ./imx-jailhouse/jailhouse-services/ivshmem.ko /tmp/
adb push ./imx-jailhouse/jailhouse-services/snd-nxp-af-ivshmem.ko /tmp/
adb push ./imx-jailhouse/jailhouse-services/rpmsg-alsa.ko /tmp/
adb push ./imx-jailhouse/jailhouse-services/rpmsg-binary.ko /tmp/
adb push ./imx-jailhouse/jailhouse-services/rpmsg-console.ko /tmp/
adb push ./imx-jailhouse/jailhouse-services/rpmsg-ppp.ko /tmp/
adb push ./imx-jailhouse/jailhouse-services/rpmsg-rpc-linux.ko /tmp/
adb push ./imx-jailhouse/jailhouse-services/rpmsg-rpc.ko /tmp/
adb push ./jailhouse-af/scripts/afrun.sh /tmp/
adb push ./jailhouse-af/scripts/jinit.sh /tmp/
adb push ./jailhouse-af/scripts/jstart.sh /tmp/
adb push ./jailhouse-af/scripts/jkill.sh /tmp/
adb push ./jailhouse-af/scripts/default.rest /tmp/
pushd $SDK_PATH
adb push ./sdk/build/cmake/pp_debug/lk.bin /tmp/
adb push ./sdk/build/cmake/pp_debug/sony_ha_bb_lk.dtb /tmp/
 
# mv /tmp/jailhouse.ko /lib/modules/4.14.78-imx_4.14.78_1.0.0_ga+gXXXXXXX/extra/driver/
# mv /tmp/jailhouse.bin /lib/firmware/
# mv /tmp/imx8mm.cell /usr/local/share/jailhouse/
# mv /tmp/imx8mm-lk.cell /usr/local/share/jailhouse/
# mv /tmp/jailhouse /usr/local/bin/
# mv /tmp/*.ko /lib/modules/4.14.78-imx_4.14.78_1.0.0_ga+gXXXXXXXX/extra/
# mv /tmp/*.sh /usr/local/bin/
# mv /tmp/default.rest /usr/local/share/rest/
# mv /tmp/lk.bin /usr/local/share/jailhouse/
# mv /tmp/sony_ha_bb_lk.dtb /usr/local/share/jailhouse/

adb shell mv /tmp/jailhouse.ko /lib/modules/4.14.78-imx_4.14.78_1.0.0_ga+g1eb3e9b/extra/driver/
adb shell mv /tmp/jailhouse.bin /lib/firmware/
adb shell mv /tmp/imx8mm.cell /usr/local/share/jailhouse/
adb shell mv /tmp/imx8mm-lk.cell /usr/local/share/jailhouse/
adb shell mv /tmp/jailhouse /usr/local/bin/
adb shell mv /tmp/*.ko /lib/modules/4.14.78-imx_4.14.78_1.0.0_ga+g1eb3e9b/extra/
adb shell mv /tmp/*.sh /usr/local/bin/
adb shell mv /tmp/default.rest /usr/local/share/rest/
adb shell mv /tmp/lk.bin /usr/local/share/jailhouse/
adb shell mv /tmp/sony_ha_bb_lk.dtb /usr/local/share/jailhouse/

popd
popd
