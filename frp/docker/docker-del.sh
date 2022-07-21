#!/bin/sh
#docker rm -f loamen-mysql -v
source ./version.sh
docker rm -f -v $(docker ps -a | grep "loamen/frp:${version}" | awk '{print $1}')
docker rmi loamen/frp:${version}
docker images
