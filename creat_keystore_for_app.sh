#!/bin/bash

SECUTIRY_KEY_PATH="${PWD}/build/target/product/security"
OUT_PATH="${PWD}/sys_keystore"
KEYSTORE_NAME="sys_key.jks"
KEYSTORE_pkcs12_NAME="sys_key_pkcs12.jks"
ALIASS_NAME="name"
PASSWORD="p@ss"

echo "======================================================"
echo $SECUTIRY_KEY_PATH
echo $OUT_PATH
echo $KEYSTORE_NAME
echo $KEYSTORE_pkcs12_NAME
echo $ALIASS_NAME
echo $PASSWORD
echo "======================================================"

rm -R ${OUT_PATH}
mkdir ${OUT_PATH}
echo "./keytool-importkeypair -k ${OUT_PATH}/${KEYSTORE_NAME} -p "${PASSWORD}" -pk8 ${SECUTIRY_KEY_PATH}/platform.pk8 -cert ${SECUTIRY_KEY_PATH}/platform.x509.pem -alias ${ALIASS_NAME}"
echo " "
./keytool-importkeypair -k ${OUT_PATH}/${KEYSTORE_NAME} -p "${PASSWORD}" -pk8 ${SECUTIRY_KEY_PATH}/platform.pk8 -cert ${SECUTIRY_KEY_PATH}/platform.x509.pem -alias ${ALIASS_NAME}

if [[ -e  ${OUT_PATH}/${KEYSTORE_NAME} ]]; then
	#statements
	echo ""
	echo ${PASSWORD} | keytool -importkeystore -srckeystore ${OUT_PATH}/${KEYSTORE_NAME} -destkeystore ${OUT_PATH}/${KEYSTORE_NAME} -deststoretype pkcs12
	if [[ -e  ${OUT_PATH}/${KEYSTORE_NAME} ]]; then
	   mv ${OUT_PATH}/${KEYSTORE_NAME} ${OUT_PATH}/${KEYSTORE_pkcs12_NAME}
	   # rm ${OUT_PATH}/${KEYSTORE_NAME}.old
	   echo $ALIASS_NAME > ${OUT_PATH}/Readme.txt
	   echo $PASSWORD   >> ${OUT_PATH}/Readme.txt
	   echo " "
	   echo "..........OKAY!!!!! Key was created.......... ${OUT_PATH}/${KEYSTORE_pkcs12_NAME}"
	   echo "MD5SUM : " 
	   md5sum ${OUT_PATH}/${KEYSTORE_pkcs12_NAME}
	   echo " "
	   exit 0
	fi
fi

echo "FAILED!!!!! Key was NOT created.........."
