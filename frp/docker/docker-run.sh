#!/bin/sh
source ./version.sh
docker run --privileged=true --name loamen-frp -p 80:80 -d loamen/frp:${version}
docker ps
