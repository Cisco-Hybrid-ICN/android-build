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

IMAGE=$(docker images -q hicn_environment)

if [ "$IMAGE" = "" ]; then
    echo "hicn_environment docker image does not exist"
    docker build -t hicn_environment -f Dockerfile_env .
fi

IMAGE=$(docker images -q hicn_dependencies)

if [ "$IMAGE" = "" ]; then
    echo "hicn_dependencies docker image does not exist"
    docker build --build-arg DOCKER_IMAGE=hicn_environment -t hicn_dependencies -f Dockerfile_dep .
fi

IMAGE=$(docker images -q hicn)

if [ "$IMAGE" = "" ]; then
    echo "hicn docker image does not exist"
    docker build --build-arg DOCKER_IMAGE=hicn_dependencies -t hicn -f Dockerfile_hicn .
fi

IMAGE=$(docker images -q hapk)

if [ "$IMAGE" = "" ]; then
    echo "hapk docker image does not exist"
    docker build --build-arg DOCKER_IMAGE=hicn -t hapk -f Dockerfile_hapk .
fi
