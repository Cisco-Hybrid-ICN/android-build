#############################################################################
# Copyright (c) 2019 Cisco and/or its affiliates.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at:
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
##############################################################################

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
        wget https://www.openssl.org/source/openssl-1.1.1d.tar.gz -P /src/ --show-progress --progress=bar:force 2>&1 
    fi
    tar -zxvf /src/openssl-1.1.1d.tar.gz -C /build_aarch64
fi

cd /build_aarch64/openssl-1.1.1d

./Configure -d ${architecture} -D__ANDROID_API__=$ANDROID_API no-shared no-unit-test --prefix=/usr_aarch64
make install_sw

cd /

rm -rf /build_aarch64

mkdir -p /build_i686
architecture=android-x86

if [ ! -d /build_i686/openssl-1.1.1d ]; then
    if [ ! -f /src/openssl-1.1.1d.tar.gz ]; then
        if [ ! -f openssl-1.1.1d.tar.gz ]; then
            wget https://www.openssl.org/source/openssl-1.1.1d.tar.gz --show-progress --progress=bar:force 2>&1 
        fi
        tar -zxvf openssl-1.1.1d.tar.gz -C /build_i686
    else
        tar -zxvf /src/openssl-1.1.1d.tar.gz -C /build_i686
    fi
fi

cd /build_i686/openssl-1.1.1d
./Configure -d ${architecture} -D__ANDROID_API__=$ANDROID_API no-shared no-unit-test --prefix=/usr_i686
make install_sw

rm -rf /build_i686

rm -rf /src/openssl-1.1.1d.tar.gz
    