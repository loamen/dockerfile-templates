#docker rm -f loamen-mysql -v
docker rm -f -v $(docker ps -a | grep "loamen/frp:0.37.1" | awk '{print $1}')
docker rmi loamen/frp:0.37.1
docker images
