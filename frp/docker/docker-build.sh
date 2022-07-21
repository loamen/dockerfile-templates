#!/bin/sh
#docker build -f Dockerfile -t loamen/frp:0.37.1 --no-cache=true .
#docker build -f Dockerfile -t loamen/frp:0.39.1 .
source ./version.sh
docker build -f Dockerfile -t loamen/frp:${version} .
docker images
