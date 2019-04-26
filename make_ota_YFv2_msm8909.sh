#!/bin/bash

# Author: Ivan Do
# Description: 

PRODUCT="msm8909"

echo "Build Android OTA Package for SC20 ${PRODUCT}....."
echo "==================================="
echo ""
rm ${PWD}/out/target/product/${PRODUCT}/system/build.prop

./build_ota.sh ${PRODUCT}

echo "Read ${PRODUCT}.log for build detail!"

echo ""
echo "==================================="
