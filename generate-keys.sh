#!/bin/bash

company_name = $1

cd ~/android/evolutionx/vendor/evolution/build/target/product/security

    ../../../../../../development/tools/make_key releasekey '/CN=$company_name/'
    ../../../../../../development/tools/make_key platform '/CN=$company_name/'
    ../../../../../../development/tools/make_key shared '/CN=$company_name/'
    ../../../../../../development/tools/make_key media '/CN=$company_name/'
    ../../../../../../development/tools/make_key networkstack '/CN=$company_name/'
    ../../../../../../development/tools/make_key sdk_sandbox '/CN=$company_name/'
    ../../../../../../development/tools/make_key bluetooth '/CN=$company_name/'

    
openssl genrsa 4096 | openssl pkcs8 -topk8 -scrypt -out avb.pem
    
    ../../../../../../external/avb/avbtool extract_public_key --key avb.pem --output avb_pkmd.bin

signify-openbsd -G -n -p factory.pub -s factory.sec
