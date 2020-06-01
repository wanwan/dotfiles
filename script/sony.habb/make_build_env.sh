# bsp のトップディレクトリを求める
BENTEN_BUILD_DIR=`repo list -r hgrm\.bsp\.build -p -f`
BSP_ROOT=`dirname "$BENTEN_BUILD_DIR"`
 
# hagoromo のトップディレクトリを求める
WMAKE_DIR=`repo list -r pfsw\.wmake -p -f`
HGRM_ROOT=`dirname "$WMAKE_DIR"`
 
# ビルド環境を設定する
cd $BSP_ROOT
source build/envsetup.sh
lunch
