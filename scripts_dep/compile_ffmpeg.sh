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

if [ ! -f /src/ffmpeg-master-android-clang.tar.xz ]; then
	wget -P /src https://iweb.dl.sourceforge.net/project/avbuild/android/ffmpeg-master-android-clang.tar.xz --show-progress --progress=bar:force 2>&1 
fi
	
tar xf /src/ffmpeg-master-android-clang.tar.xz -C /src
mv /src/ffmpeg-master-android-clang /src/ffmpeg
mkdir -p /usr_aarch64/include/
mkdir -p /usr_aarch64/lib/
cp -r /src/ffmpeg/include/* /usr_aarch64/include/
cp /src/ffmpeg/lib/arm64-v8a/lib* /usr_aarch64/lib/

rm -rf /src/ffmpeg*
