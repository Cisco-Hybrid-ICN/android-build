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

if [ ! -d /usr_aarch64/include/asio ]; then
	if [ ! -d /src/asio ]; then
		git clone https://github.com/chriskohlhoff/asio.git /src/asio
		cd /src/asio
		git checkout tags/asio-1-12-2
	fi
	cp -rf /src/asio/asio/include/asio.hpp /usr_aarch64/include/
	cp -rf /src/asio/asio/include/asio /usr_aarch64/include/
fi

if [ ! -d /usr_i686/include/asio ]; then
	if [ ! -d /src/asio ]; then
		git clone https://github.com/chriskohlhoff/asio.git
		cd /src/asio
		git checkout tags/asio-1-12-2
	fi
	cp -rf /src/asio/asio/include/asio.hpp /usr_i686/include/
	cp -rf /src/asio/asio/include/asio /usr_i686/include/
fi

rm -rf /src/asio