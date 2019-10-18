#!/bin/bash

set -ex

export ANDROID_NDK_HOME=/opt/android-sdk-linux/ndk-bundle/

toolchains_path=$(python /scripts_dep/toolchains_path.py --ndk ${ANDROID_NDK_HOME})
CC=clang
echo $PATH
PATH=$toolchains_path/bin:$PATH
ANDROID_API=26
architecture=android-arm64

mkdir -p /build_aarch64
mkdir -p /src

if [ ! -d /build_aarch64/openssl-1.1.1d ]; then
    if [ ! -f /src/openssl-1.1.1d.tar.gz ]; then
        wget https://www.openssl.org/source/openssl-1.1.1d.tar.gz -P /src/
    fi
    tar -zxvf /src/openssl-1.1.1d.tar.gz -C /build_aarch64
fi

cd /build_aarch64/openssl-1.1.1d

./Configure -d ${architecture} -D__ANDROID_API__=$ANDROID_API no-shared no-unit-test --prefix=/usr_aarch64
make install_sw

cd /

mkdir -p /build_x86
architecture=android-x86

if [ ! -d /build_x86/openssl-1.1.1d ]; then
    if [ ! -f /src/openssl-1.1.1d.tar.gz ]; then
        if [ ! -f openssl-1.1.1d.tar.gz ]; then
            wget https://www.openssl.org/source/openssl-1.1.1d.tar.gz
        fi
        tar -zxvf openssl-1.1.1d.tar.gz -C /build_x86
    else
        tar -zxvf /src/openssl-1.1.1d.tar.gz -C /build_x86
    fi
fi

cd /build_x86/openssl-1.1.1d
./Configure -d ${architecture} -D__ANDROID_API__=$ANDROID_API no-shared no-unit-test --prefix=/usr_x86
make install_sw
    