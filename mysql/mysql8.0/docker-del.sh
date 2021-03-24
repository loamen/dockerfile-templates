#docker rm -f loamen-mysql -v
docker rm -f -v $(docker ps -a | grep "loamen-mysql:8.0" | awk '{print $1}')
docker rmi loamen-mysql:8.0