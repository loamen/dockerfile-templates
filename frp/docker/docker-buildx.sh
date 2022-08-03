#!/bin/sh
source ./version.sh
docker buildx build --platform linux/arm,linux/arm64,linux/amd64,linux/386,linux/arm/v6 -t loamen/frp:${version} --push -f ./Dockerfile .