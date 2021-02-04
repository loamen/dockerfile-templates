docker rm -f loamen-mysql:5.7 -v
#docker rm -f -v $(docker ps -a | grep "loamen-mysql:5.7" | awk '{print $1}')
docker rmi loamen-mysql:5.7