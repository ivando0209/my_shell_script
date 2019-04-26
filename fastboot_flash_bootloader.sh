#!/bin/bash
adb shell reboot bootloader

fastboot devices
fastboot flash aboot out/target/product/msm8909/emmc_appsboot.mbn
fastboot reboot

