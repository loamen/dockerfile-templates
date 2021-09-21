docker run --privileged=true --name loamen-frp \
	--env FRP_TYPE=client \
	-p 80:80 \
	-p 9000:9000 \
	-v ~/workspace/dockerfile-templates/frp/test/nginx/html:/usr/share/nginx/html \
	-v ~/workspace/dockerfile-templates/frp/test/nginx/conf:/etc/nginx/conf.d \
	-v ~/workspace/dockerfile-templates/frp/test/frp/conf:/opt/frp/conf \
	-v ~/workspace/dockerfile-templates/frp/test/frp/logs:/opt/frp/logs \
	-d loamen/frp:0.37.1