#!/bin/bash
DEF_CONFIG="imx6s_android_defconfig"
#COMPILER="../prebuilts/gcc/linux-x86/arm/arm-eabi-4.8/bin/arm-eabi-"
COMPILER="../prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-"
FLAG="KCFLAGS=-mno-android"
#export ARCH=arm
#export CROSS_COMPILE=/media/phuocdo/D2/1.Project/iMX6_Android/1.Source_Android/0.1_Build_source_5.1/myandroid/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-
cd kernel_imx
make  -j8  ARCH=arm CROSS_COMPILE=$COMPILER  $DEF_CONFIG
echo "*************************************************************************************************************************************"
cat .config
echo "*************************************************************************************************************************************"

make -j8  ARCH=arm CROSS_COMPILE=$COMPILER  uImage LOADADDR=0x10008000 $FLAG

make -j8  ARCH=arm CROSS_COMPILE=$COMPILER imx6dl-sabresd.dtb

cd ..

