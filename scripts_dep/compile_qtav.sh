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

export ANDROID_NDK_ROOT=$ANDROID_HOME/ndk-bundle/
if [ ! -d /src/QtAV ]; then
	git clone https://github.com/wang-bin/QtAV.git /src/QtAV
	cd /src/QtAV
	git checkout tags/v1.13.0
fi

cd /src/QtAV
git submodule update --init
echo "INCLUDEPATH = /usr_aarch64/include/" > .qmake.conf
echo "LIBS = -L/usr_aarch64/lib/" >> .qmake.conf
mkdir -p /build_aarch64/qtav
cd /build_aarch64/qtav
$QT_HOME/$QT_VERSION/android_arm64_v8a/bin/qmake /src/QtAV/QtAV.pro -spec android-clang
make
make install INSTALL_ROOT=android_arm64_v8a
cat sdk_install.sh
sh sdk_install.sh

rm -rf /build_aarch64

echo "INCLUDEPATH = /usr_i686/include/" > .qmake.conf
echo "LIBS = -L/usr_i686/lib/" >> .qmake.conf
mkdir -p /build_i686/qtav
cd /build_i686/qtav
$QT_HOME/$QT_VERSION/android_x86/bin/qmake /src/QtAV/QtAV.pro -spec android-clang
make
make install INSTALL_ROOT=android_x86
cat sdk_install.sh
sh sdk_install.sh

rm -rf /build_i686

rm -rf /src/QtAV
