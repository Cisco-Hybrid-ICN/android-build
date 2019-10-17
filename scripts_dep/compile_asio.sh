#!/bin/bash

set -ex

mkdir -p src

if [ ! -d /usr_aarch64/include/asio ]; then
	if [ ! -d /src/asio ]; then
		git clone https://github.com/chriskohlhoff/asio.git /src/asio
		cd /src/asio
		git checkout tags/asio-1-12-2
	fi
	cp -rf /src/asio/asio/include/asio.hpp /usr_aarch64/include/
	cp -rf /src/asio/asio/include/asio /usr_aarch64/include/
fi

if [ ! -d /usr_x86/include/asio ]; then
	if [ ! -d /src/asio ]; then
		git clone https://github.com/chriskohlhoff/asio.git
		cd /src/asio
		git checkout tags/asio-1-12-2
	fi
	cp -rf /src/asio/asio/include/asio.hpp /usr_x86/include/
	cp -rf /src/asio/asio/include/asio /usr_x86/include/
fi