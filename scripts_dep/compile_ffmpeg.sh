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

if [ ! -f ffmpeg-master-android-clang.tar.xz ]; then
	wget https://iweb.dl.sourceforge.net/project/avbuild/android/ffmpeg-master-android-clang.tar.xz
fi
	
tar xf ffmpeg-master-android-clang.tar.xz
mv ffmpeg-master-android-clang ffmpeg
mkdir -p /usr_aarch64/include/
mkdir -p /usr_aarch64/lib/
cp -r ffmpeg/include/* /usr_aarch64/include/
cp ffmpeg/lib/arm64-v8a/lib* /usr_aarch64/lib/
