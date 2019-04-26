#!/bin/bash

# For Ubuntu  64b:

RED="\e[31m"
BLUE="\e[34m"
GREEN="\e[32m"
COLOR_RST="\e[39m"
BOLD="\e[1m"
TYPE_RST="\e[0m"

echo -e "$BLUE Install 32b lib for Ubuntu 64b $COLOR_RST"
	sudo apt-get install lib32gcc1  libc6:i386
	sudo apt-get install autoconf m4
	sudo apt-get install lib32stdc++6 lib32z1 lib32z1-dev
	sudo apt-get install gperf libxml2-utils
	sudo apt-get install python2.7=2.7.6-8ubuntu0.4 
	sudo apt-get install libxml2-utils bison

echo -e "$BLUE Install addition to the packages requested on the Android $COLOR_RST"
	sudo apt-get install libuuid1=2.20.1-5.1ubuntu20
	sudo apt-get install uuid uuid-dev 
	sudo apt-get install zlib1g-dev liblz-dev
	sudo apt-get install liblzo2-2 liblzo2-dev 
	sudo apt-get install lzop git-core curl u-boot-tools
	sudo apt-get install mtd-utils
	sudo apt-get install android-tools-fsutils
	sudo apt-get install simg2img

echo -e "$BLUE Install Java JDK 7 for Android 5.1 $COLOR_RST"
	sudo add-apt-repository ppa:openjdk-r/ppa
	sudo apt-get update
	sudo apt-get install openjdk-7-jdk
echo -e "$BLUE Choose JDK 7 is default java version if OS have install many java versions: $COLOR_RST"	
	sudo update-alternatives --config java 	
	sudo update-alternatives --config javac
	sudo update-alternatives --config javap
	sudo update-alternatives --config javadoc
	sudo update-alternatives --config javah
	
echo -e "$GREEN ------------------ DONE -----------------"

# For Ubuntu 16.04 64b:
# Read http://oopsmonk.github.io/blog/2016/06/07/android-build-error-on-ubuntu-16-04-lts to fix "error unsupported reloc" 
#
# Modify build/core/clang/HOST_x86_common.mk
# diff --git a/core/clang/HOST_x86_common.mk b/core/clang/HOST_x86_common.mk
# index 0241cb6..77547b7 100644
# --- a/core/clang/HOST_x86_common.mk
# +++ b/core/clang/HOST_x86_common.mk
# @@ -8,6 +8,7 @@ ifeq ($(HOST_OS),linux)
#
#  CLANG_CONFIG_x86_LINUX_HOST_EXTRA_ASFLAGS := \
#    --gcc-toolchain=$($(clang_2nd_arch_prefix)HOST_TOOLCHAIN_FOR_CLANG) \
#    --sysroot=$($(clang_2nd_arch_prefix)HOST_TOOLCHAIN_FOR_CLANG)/sysroot \
# +  -B$($(clang_2nd_arch_prefix)HOST_TOOLCHAIN_FOR_CLANG)/x86_64-linux/bin \
#    -no-integrated-as
#  CLANG_CONFIG_x86_LINUX_HOST_EXTRA_CFLAGS := \ 
