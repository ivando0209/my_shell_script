#!/bin/bash
adb shell reboot bootloader

sudo fastboot devices
sudo fastboot erase boot
sudo fastboot flash boot out/target/product/msm8909/boot.img
sudo fastboot reboot

