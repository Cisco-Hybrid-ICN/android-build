#!/bin/bash

set -ex

mkdir -p /src
export ANDROID_NDK_HOME=/opt/android-sdk-linux/ndk-bundle/
if [ ! -d /src/libevent ]; then
    git clone https://github.com/libevent/libevent.git /src/libevent
fi
LIBEVENT_SRC=/src/libevent


mkdir -p /build_aarch64/libevent
cd /build_aarch64/libevent

/opt/android-sdk-linux/cmake/$ANDROID_CMAKE_REV_3_10/bin/cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake \
                        -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static \
                        -DANDROID_ABI=arm64-v8a \
                        -DCMAKE_FIND_ROOT_PATH=/usr_aarch64  \
                        -DANDROID_NATIVE_API_LEVEL=26 \
						-DEVENT__LIBRARY_TYPE="STATIC" -DEVENT__DISABLE_TESTS=ON \
					    -DCMAKE_INSTALL_PREFIX=/usr_aarch64 $LIBEVENT_SRC

make -j install

mkdir -p /build_i686/libevent
cd /build_i686/libevent

/opt/android-sdk-linux/cmake/$ANDROID_CMAKE_REV_3_10/bin/cmake -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake \
                        -DANDROID_TOOLCHAIN=clang -DANDROID_STL=c++_static \
                        -DANDROID_ABI=x86 \
                        -DCMAKE_FIND_ROOT_PATH=/usr_i686  \
                        -DANDROID_NATIVE_API_LEVEL=26 \
						-DEVENT__LIBRARY_TYPE="STATIC" -DEVENT__DISABLE_TESTS=ON \
					    -DCMAKE_INSTALL_PREFIX=/usr_i686 $LIBEVENT_SRC

make -j install
