#!/bin/bash

set -ex

mkdir -p /src
mkdir -p /apks

export ANDROID_NDK_HOME=/opt/android-sdk-linux/ndk-bundle/
if [ ! -d /src/android-sdk ]; then
    git clone https://github.com/icn-team/android-sdk.git /src/android-sdk
fi

ln -s /usr_aarch64 /src/android-sdk
ln -s /usr_i686 /src/android-sdk

cd /src/android-sdk/HicnForwarderAndroid
echo sdk.dir=${ANDROID_HOME} > local.properties
echo ndk.dir=${ANDROID_HOME}/ndk-bundle >> local.properties
./gradlew assembleRelease

cp app/build/outputs/apk/release/*.apk /apks


cd /src/android-sdk/hICNTools
echo sdk.dir=${ANDROID_HOME} > local.properties
echo ndk.dir=${ANDROID_HOME}/ndk-bundle >> local.properties
./gradlew assembleRelease
cp app/build/outputs/apk/release/*.apk /apks

ls /apks
