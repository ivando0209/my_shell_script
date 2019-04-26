#!/bin/bash

TARGET_IP="192.168.10.31"

HOST_SRC_PATH="/media/phuocdo/1TB_Disk/1.Project/2.Android/v6.0.1/1.PA_Kiosk/pa_kiosk-userdebug-built_out/target/product/pa_kiosk"
# HOST_SRC_PATH="/media/phuocdo/1TB_Disk/1.Project/2.Android/v6.0.1/myandroid_built_OUT/target/product/pa_kiosk"


if [[ -z $1 ]]; then
	echo "Please add option: -b: boot-imx6q.img or -s: system_raw.img or file path"
	exit 1
fi

ping -c 1 -W 1 $TARGET_IP 

if [[  $? -gt 0 ]]; then
	echo "Target IP: $TARGET_IP is not alive! "
	exit 1
fi

echo "Target IP: $TARGET_IP is alive! "

FILE_NAME=""

if [[ "$1" == "-u" ]]; then
		FILE_NAME="u-boot-imx6q.imx"
else if [[ "$1" == "-r" ]]; then
		FILE_NAME="recovery-imx6q.img"
else if [[ "$1" == "-b" ]]; then
		FILE_NAME="boot-imx6q.img"
else if [[ "$1" == "-rldo" ]]; then
		FILE_NAME="recovery-imx6q-ldo.img"
else if [[ "$1" == "-bldo" ]]; then
		FILE_NAME="boot-imx6q-ldo.img"		
else if [[ "$1" == "-s" ]]; then
		sudo simg2img $HOST_SRC_PATH/system.img $HOST_SRC_PATH/system_raw.img
		FILE_NAME="system_raw.img"
	else
		FILE_NAME="$1"
		scp $FILE_NAME root@$TARGET_IP:/boot/
		exit 0
	fi
	fi
	fi
	fi
	fi
fi


ls -l $HOST_SRC_PATH/$FILE_NAME
md5sum $HOST_SRC_PATH/$FILE_NAME

scp $HOST_SRC_PATH/$FILE_NAME root@$TARGET_IP:/boot/

exit 0