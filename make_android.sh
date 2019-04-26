#!/bin/bash

reset 

RED="\e[31m"
BLUE="\e[34m"
GREEN="\e[32m"
COLOR_RST="\e[39m"
BOLD="\e[1m"
TYPE_RST="\e[0m"


echo -e "$BLUE================================================="
echo -e "Set build enviroment: "
echo -e "=================================================$COLOR_RST"

source build/envsetup.sh

echo "======================= source build/envsetup.sh ======================================"
# lunch sabresd_6dq-user
# lunch evk_6sl
# lunch sabresd_6dq-userdebug
# lunch d2_imx6dq-user

TARGET_PRODUCT="pa_kiosk"

#---------------- Release --------------------------------------------

BUILD_VARIANT="-user" 
# This mode can not run recovery

# BUILD_VARIANT="-userdebug"
Up_dir=$(dirname $PWD)
export OUT_DIR="$Up_dir/$TARGET_PRODUCT$BUILD_VARIANT-built_out"
# export OUT_DIR="$Up_dir/$TARGET_PRODUCT-user-built_out"


#---------------- Develop --------------------------------------------
# BUILD_VARIANT="-userdebug"
# export OUT_DIR="/media/phuocdo/1TB_Disk/1.Project/2.Android/v6.0.1/myandroid_built_OUT"

lunch  $TARGET_PRODUCT$BUILD_VARIANT
echo "=========================== lunch $TARGET_PRODUCT$BUILD_VARIANT =================================="

if [[ "$1" == "-r" ]]; then
	echo -e "$BLUE================================================="
	echo -e "Build Android recoveryimage "
	echo -e "=================================================$COLOR_RST"
	make -j$(nproc)  recoveryimage
	exit 0;
fi

if [[ "$1" == "-s" ]]; then
	echo -e "$BLUE================================================="
	echo -e "Remove OLD Android system "
	echo -e "=================================================$COLOR_RST"
	rm -r $OUT_DIR/target/product/$TARGET_PRODUCT/system.img $OUT_DIR/target/product/$TARGET_PRODUCT/system
fi

echo -e "$GREEN================================================="
echo -e " Building the entire  Android: "
echo -e "=================================================$COLOR_RST"
rm $OUT_DIR/target/product/$TARGET_PRODUCT/obj/ETC/system_build_prop_intermediates/build.prop
make -j$(nproc)  2>&1 | tee build-log.txt


if [[ "$1" == "-ota" ]]; then

	make -j$(nproc) otapackage
	DATE=$(date --iso-8601)
	BUILD_VERSION=$(cat $OUT_DIR/target/product/$TARGET_PRODUCT/system/build.prop  | grep ro.build.id= | awk 'BEGIN{FS="="} { print $2 }')
	mv $OUT_DIR/target/product/$TARGET_PRODUCT/$TARGET_PRODUCT-ota-${DATE}-imx6q-ldo.zip $OUT_DIR/target/product/$TARGET_PRODUCT/$TARGET_PRODUCT-ota-${DATE}-v${BUILD_VERSION}.zip
fi

if [[ !$? ]]; then
	#statements
	# if [[ "$1" == "-s" ]]; then
	# 	sudo simg2img $OUT_DIR/target/product/$TARGET_PRODUCT/system.img $OUT_DIR/target/product/$TARGET_PRODUCT/system_raw.img
	# fi

	BUILD_VERSION=$(cat $OUT_DIR/target/product/$TARGET_PRODUCT/system/build.prop  | grep ro.build.id= | awk 'BEGIN{FS="="} { print $2 }')
	
	echo -e "$GREEN================================================="
	echo -e " BUILD DONE!!!! VERSION = $BUILD_VERSION "
	date
	BUILD_ID_LOG="device/styl/$TARGET_PRODUCT/build_id.log"
	echo $(cat $BUILD_ID_LOG | awk '{print $1+1;}') > $BUILD_ID_LOG
	echo -e "=================================================$COLOR_RST"

fi


