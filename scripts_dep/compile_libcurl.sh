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

mkdir -p /src
export ANDROID_NDK_HOME=/opt/android-sdk-linux/ndk-bundle/
if [ ! -d /src/libcurl ]; then
	git clone https://github.com/curl/curl.git /src/libcurl
	cd /src/curl
	git checkout tags/curl-7_66_0
fi
LIBCURL_SRC=/src/libcurl

mkdir -p /build_aarch64/libcurl
cd /build_aarch64/libcurl

/opt/android-sdk-linux/cmake/$ANDROID_CMAKE_REV_3_10/bin/cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake \
                        -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static \
                        -DANDROID_ABI=arm64-v8a \
                        -DCMAKE_FIND_ROOT_PATH=/usr_aarch64  \
                        -DANDROID_NATIVE_API_LEVEL=26 \
					    -DCMAKE_INSTALL_PREFIX=/usr_aarch64 $LIBCURL_SRC

make -j install

rm -rf /build_aarch74

mkdir -p /build_i686/libcurl
cd /build_i686/libcurl

/opt/android-sdk-linux/cmake/$ANDROID_CMAKE_REV_3_10/bin/cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake \
                        -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static \
                        -DANDROID_ABI=x86 \
                        -DCMAKE_FIND_ROOT_PATH=/usr_i686  \
                        -DANDROID_NATIVE_API_LEVEL=26 \
					    -DCMAKE_INSTALL_PREFIX=/usr_i686 $LIBCURL_SRC

make -j install

rm -rf /build_i686

rm -rf /src/libcurl
