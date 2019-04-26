#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# boot-imx6q.img
# recovery-imx6q.img
# system.img
# u-boot-imx6q.imx
# md5sum_cal.txt

IMG_MOUNTED_ROOTFS="/media/phuocdo/s_rootfs"
ANDROID_BUILD_OUTPUT="/media/phuocdo/1TB_Disk/1.Project/2.Android/v6.0.1/1.PA_Kiosk/pa_kiosk-user-built_out/target/product/pa_kiosk"

if [[ -z $1  ]]; then
	echo "Missing version number!!!"
	exit 1
fi

if [[ -z $2  ]]; then
	echo "Flasher type!!!"
	echo "type = update "
	echo "or"
	echo "type = new "
	exit 1
else
	echo $2
	if [[ "$2" == "update" ]]; then
		#statements
		FLASHER_TYPE="UPDATE"
		FLASHER_SCRIPT="fsl-sdcard-partition_update_flash.sh"
	else 
		FLASHER_TYPE="NEW"
		FLASHER_SCRIPT="fsl-sdcard-partition_new_flash.sh"
	fi
fi

echo $ANDROID_BUILD_OUTPUT
echo "Check OUTPUT folder!!!"
read

SCRIPT_DIR=${PWD}
BASE_LINUX_PATH="${SCRIPT_DIR}/BASE_LINUX_FLASHER"
BASE_LINUX_FILE="Base_linux_imx6q.img"

FLASHER_DIR=$(dirname ${SCRIPT_DIR})
FLASHER_SAVED_PATH="${FLASHER_DIR}/1.FLASHER"

PROJECT="PA_Kiosk"
DATE=$(date --iso-8601)
VERSION="v$1"
NEW_IMG_FILE="${PROJECT}_${FLASHER_TYPE}_IMAGE_${DATE}_${VERSION}.img"

if [[ -e ${FLASHER_SAVED_PATH}/"${DATE}_${VERSION}/${NEW_IMG_FILE}" ]]; then
	echo "File ${FLASHER_SAVED_PATH}/"${DATE}_${VERSION}/${NEW_IMG_FILE}" is existed!"
	echo "Enter to continue or Ctrl-C to abort!"
	read 
fi

sudo rm -R ${FLASHER_SAVED_PATH}/"${DATE}_${VERSION}/${NEW_IMG_FILE}"
sudo mkdir -m 666 ${FLASHER_SAVED_PATH}/"${DATE}_${VERSION}"

cp  -f -v  ${BASE_LINUX_PATH}/${BASE_LINUX_FILE}  ${FLASHER_SAVED_PATH}/"${DATE}_${VERSION}"/${NEW_IMG_FILE}

# sudo kpartx -asv ${FLASHER_SAVED_PATH}/"${DATE}_${VERSION}"/${NEW_IMG_FILE}


LOOP_P1=`sudo kpartx -asv ${FLASHER_SAVED_PATH}/"${DATE}_${VERSION}"/${NEW_IMG_FILE} | awk 'NR==1 { print $3 }'`
echo "LOOP_P1=  $LOOP_P1"
sudo kpartx -dsv ${FLASHER_SAVED_PATH}/"${DATE}_${VERSION}"/${NEW_IMG_FILE}
LOOP_P2=`sudo kpartx -asv ${FLASHER_SAVED_PATH}/"${DATE}_${VERSION}"/${NEW_IMG_FILE} | awk 'NR==2 { print $3 }'`
echo "LOOP_P2=  $LOOP_P2"

mkdir ${IMG_MOUNTED_ROOTFS}
mount /dev/mapper/$LOOP_P2   ${IMG_MOUNTED_ROOTFS}
ls  ${IMG_MOUNTED_ROOTFS}/

while [[ ! -d ${IMG_MOUNTED_ROOTFS}/boot ]]; do
	echo "Please mount base linux rootfs!"
	sleep 1
done

sleep 1

echo "Copy new android img...!"
cp -f -v  ${ANDROID_BUILD_OUTPUT}/boot-imx6q-ldo.img  		${IMG_MOUNTED_ROOTFS}/boot/
cp -f -v  ${ANDROID_BUILD_OUTPUT}/system.img 				${IMG_MOUNTED_ROOTFS}/boot/
cp -f -v  ${ANDROID_BUILD_OUTPUT}/u-boot-imx6q.imx     		${IMG_MOUNTED_ROOTFS}/boot/

cp -f -v  ${PWD}/Recovery_Prebuilt_img/recovery-imx6q-ldo-v2.0.3.img 	${IMG_MOUNTED_ROOTFS}/boot/recovery-imx6q-ldo.img

echo "Copy flash script"
cp -f -v  ${BASE_LINUX_PATH}/${FLASHER_SCRIPT} 	${IMG_MOUNTED_ROOTFS}/boot/fsl-sdcard-partition.sh

echo "Caculate md5sum of android img...!"
sudo ls -l ${IMG_MOUNTED_ROOTFS}/boot/
echo ${DATE} >  ${IMG_MOUNTED_ROOTFS}/boot/md5sum_cal.txt
echo " " 	 >> ${IMG_MOUNTED_ROOTFS}/boot/md5sum_cal.txt
 
sudo md5sum ${IMG_MOUNTED_ROOTFS}/boot/boot-imx6q-ldo.img  		>> ${IMG_MOUNTED_ROOTFS}/boot/md5sum_cal.txt
sudo md5sum ${IMG_MOUNTED_ROOTFS}/boot/recovery-imx6q-ldo.img 	>> ${IMG_MOUNTED_ROOTFS}/boot/md5sum_cal.txt
sudo md5sum ${IMG_MOUNTED_ROOTFS}/boot/system.img 				>> ${IMG_MOUNTED_ROOTFS}/boot/md5sum_cal.txt
sudo md5sum ${IMG_MOUNTED_ROOTFS}/boot/u-boot-imx6q.imx      	>> ${IMG_MOUNTED_ROOTFS}/boot/md5sum_cal.txt

sync
sleep 10
sync
sudo umount ${IMG_MOUNTED_ROOTFS}
sudo kpartx -dsv ${FLASHER_SAVED_PATH}/"${DATE}_${VERSION}"/${NEW_IMG_FILE}
sleep 1
echo "Caculate md5sum of flasher img...!"
md5sum  ${FLASHER_SAVED_PATH}/"${DATE}_${VERSION}"/${NEW_IMG_FILE} >  ${FLASHER_SAVED_PATH}/"${DATE}_${VERSION}"/${NEW_IMG_FILE}.md5

sudo chmod +rwx -Rf ${FLASHER_SAVED_PATH}/"${DATE}_${VERSION}"
sudo chown $(id -u):$(id -g) ${FLASHER_SAVED_PATH}/"${DATE}_${VERSION}"

echo "DONE-----------"


