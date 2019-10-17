#!/bin/bash

set -ex

mkdir -p /src
export ANDROID_NDK_HOME=/opt/android-sdk-linux/ndk-bundle/
if [ ! -d /src/libconfig ]; then
	git clone https://github.com/hyperrealm/libconfig.git /src/libconfig
	sed -i -- '2s/$/include(CheckSymbolExists)/' /src/libconfig/CMakeLists.txt
fi
LIBCONFIG_SRC=/src/libconfig

mkdir -p /build_aarch64/libconfig
cd /build_aarch64/libconfig

/opt/android-sdk-linux/cmake/$ANDROID_CMAKE_REV_3_10/bin/cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake \
                        -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static \
                        -DANDROID_ABI=arm64-v8a \
                        -DCMAKE_FIND_ROOT_PATH=/usr_aarch64  \
                        -DANDROID_NATIVE_API_LEVEL=26 \
						-DBUILD_TESTS=OFF \
						-DBUILD_SHARED_LIBS=OFF \
					    -DCMAKE_INSTALL_PREFIX=/usr_aarch64 $LIBCONFIG_SRC

make -j install

mkdir -p /build_x86/libconfig
cd /build_x86/libconfig

/opt/android-sdk-linux/cmake/$ANDROID_CMAKE_REV_3_10/bin/cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake \
                        -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static \
                        -DANDROID_ABI=x86 \
                        -DCMAKE_FIND_ROOT_PATH=/usr_x86  \
                        -DANDROID_NATIVE_API_LEVEL=26 \
						-DBUILD_TESTS=OFF \
						-DBUILD_SHARED_LIBS=OFF \
					    -DCMAKE_INSTALL_PREFIX=/usr_x86 $LIBCONFIG_SRC

make -j install
