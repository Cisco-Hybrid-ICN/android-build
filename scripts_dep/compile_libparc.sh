#!/bin/bash

set -ex

mkdir -p /src
export ANDROID_NDK_HOME=/opt/android-sdk-linux/ndk-bundle/
if [ ! -d /src/cframework ]; then
	git clone -b cframework/master https://gerrit.fd.io/r/cicn /src/cframework
fi
LIBPARC_SRC=/src/cframework/libparc

mkdir -p /build_aarch64/libparc
cd /build_aarch64/libparc
/opt/android-sdk-linux/cmake/$ANDROID_CMAKE_REV_3_10/bin/cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake \
                        -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static \
                        -DANDROID_ABI=arm64-v8a \
                        -DCMAKE_FIND_ROOT_PATH=/usr_aarch64  \
                        -DANDROID_NATIVE_API_LEVEL=26 \
					    -DCMAKE_INSTALL_PREFIX=/usr_aarch64 $LIBPARC_SRC

make -j install

mkdir -p /build_x86/libparc
cd /build_x86/libparc

/opt/android-sdk-linux/cmake/$ANDROID_CMAKE_REV_3_10/bin/cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake \
                        -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static \
                        -DANDROID_ABI=x86 \
                        -DCMAKE_FIND_ROOT_PATH=/usr_x86  \
                        -DANDROID_NATIVE_API_LEVEL=26 \
					    -DCMAKE_INSTALL_PREFIX=/usr_x86 $LIBPARC_SRC

make -j install
