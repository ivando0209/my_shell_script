#!/bin/bash

if [[ -z $1 ]]; then
	echo "Missing ota update_package file!!!!!"
	PACKAGE="/media/phuocdo/1TB_Disk/1.Project/6.BV_SC20/0.Android_source/v7.1.2_codeaurora/out/target/product/msm8909/msm8909-ota-eng.phuocdo.zip"
else
	PACKAGE=$1
fi


adb root
sleep 1
echo "Waiting for device ........."
adb wait-for-device
adb root

adb shell "reboot recovery"
echo "In recovery mode: Press Vol_down to select Aplly update from ADB, Press Pwr"
adb wait-for-device
adb root

echo "Enter to continue"
read
echo "Enter to continue"
read

adb sideload $PACKAGE

exit 0

# cp  $1 /tmp/ota_package.zip

# sleep 1
# adb shell "rm -r /cache/ota/"
# adb shell "mkdir /cache/ota/"
# echo "Sending ota_package to board...."
# adb push  $PACKAGE '/data/ota_package/ota_package.zip'
# adb shell "echo 'boot-recovery' > /cache/recovery/command"
# adb shell "echo '--update_package=/data/ota_package/ota_package.zip' >> /cache/recovery/command "
# adb shell "echo '--wipe_data ' >> /cache/recovery/command"
# adb shell "echo '--wipe_cache ' >> /cache/recovery/command"
# adb shell "echo 'reboot ' >> /cache/recovery/command"
# adb shell "cat /cache/recovery/command"
# adb shell "reboot recovery"

echo "=======Done========"

