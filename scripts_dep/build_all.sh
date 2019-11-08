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

function show_help {
    echo "--skip-openssl = skip the openssl libraries building"
    echo "--skip-libevent = skip the libevent libraries building"
    echo "--skip-asio = skip the asio libraries building"
    echo "--skip-libconfig = skip the libconfig libraries building"
    echo "--skip-libxml2 = skip the libxml2 libraries building"
    echo "--skip-libcurl = skip the libcurl libraries building"
    echo "--skip-libash = skip the libdash libraries building"
    echo "--skip-ffmpeg = skip the ffmpeg libraries building"
    echo "--skip-qtav = skip the qtav libraries building"
}

SKIP_OPENSSL=0
SKIP_LIBEVENT=0
SKIP_ASIO=0
SKIP_LIBCONFIG=0
SKIP_LIBXML2=0
SKIP_LIBCURL=0
SKIP_LIBDASH=0
SKIP_FFMPEG=0
SKIP_QTAV=0

for var in "$@"
do
    case $var in
        "--skip-openssl")      
            SKIP_OPENSSL=1
            ;;
        "--skip-libevent")      
            SKIP_LIBEVENT=1
            ;;
        "--skip-asio")      
            SKIP_ASIO=1
            ;;
        "--skip-libconfig")      
            SKIP_LIBCONFIG=1
            ;;
        "--skip-libxml2")      
            SKIP_LIBDASH=1
            ;;
         "--skip-libdash")      
            SKIP_LIBDASH=1
            ;;
         "--skip-ffmpeg")      
            SKIP_FFMPEG=1
            ;;
         "--skip-qtav")      
            SKIP_QTAV=1
            ;;
         "--help")
            show_help
            exit 0
            ;;
        *)
            echo "command $var not found"
            show_help
            exit 1;
             ;;
    esac
done

if [ $SKIP_OPENSSL -eq 0 ]; then
   bash /scripts_dep/compile_openssl.sh
fi

if [ $SKIP_LIBEVENT -eq 0 ]; then
    bash /scripts_dep/compile_libevent.sh
fi

if [ $SKIP_ASIO -eq 0 ]; then
    bash /scripts_dep/compile_asio.sh
fi

if [ $SKIP_LIBCONFIG -eq 0 ]; then
    bash /scripts_dep/compile_libconfig.sh
fi

if [ $SKIP_LIBCURL -eq 0 ]; then
    bash /scripts_dep/compile_libcurl.sh
fi

if [ $SKIP_LIBXML2 -eq 0 ]; then
    bash /scripts_dep/compile_libxml2.sh
fi

if [ $SKIP_LIBDASH -eq 0 ]; then
    bash /scripts_dep/compile_libdash.sh
fi

if [ $SKIP_FFMPEG -eq 0 ]; then
   bash /scripts_dep/compile_ffmpeg.sh
fi

if [ $SKIP_QTAV -eq 0 ]; then
   bash /scripts_dep/compile_qtav.sh
fi


