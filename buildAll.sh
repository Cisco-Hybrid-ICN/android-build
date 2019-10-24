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
