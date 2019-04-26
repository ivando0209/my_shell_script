#!/bin/bash

# Author: Ivan Do
# Description: 

PRODUCT="msm8909"

echo "Build Android for SC20 ${PRODUCT}....."
echo "==================================="
echo ""
rm ${PWD}/out/target/product/${PRODUCT}/system/build.prop
rm ${PWD}/out/target/product/${PRODUCT}/system/build.prop*

./build.sh ${PRODUCT}

# ./build.sh ${PRODUCT} -i bootimg

echo "Read ${PRODUCT}.log for build detail!"
echo ""
echo "==================================="
