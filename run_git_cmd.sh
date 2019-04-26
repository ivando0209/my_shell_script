#!/bin/bash
SCRIPT_DIR=${PWD}

KERNEL_DIR="kernel/"
MSM8909_DIR="device/qcom/msm8909/"
QCOM_COMMON="device/qcom/common/"

if [[ "$1" == "-k" ]]; then
	GIT_DIR="$KERNEL_DIR"
elif [[ "$1" == "-msm" ]]; then
	GIT_DIR="$MSM8909_DIR"
elif [[ "$1" == "-com" ]]; then
	GIT_DIR="$QCOM_COMMON"
else
	echo "Miss projects git!! "
fi

cd $GIT_DIR

git $2 $3 $4 $5 $6 $7 $8

echo "==================================="
echo "PPWD PATH: $KERNEL_DIR"
echo "git $2 $3 $4 $5 $6 $7 $8"
echo "==================================="


cd $SCRIPT_DIR



