## 1.Frp简介
	frp 是一个专注于内网穿透的高性能的反向代理应用，支持 TCP、UDP、HTTP、HTTPS 等多种协议。可以将内网服务以安全、便捷的方式通过具有公网 IP 节点的中转暴露到公网。
	docker frp提供frps和frpc容器版本，并自带nginx，用于frpc穿透指向到不同服务器。

## 2.获取docker frp
> $ docker pull  loamen/frp:0.37.1

## 3.目录结构
```
/opt/frp/
|-- LICENSE
|-- conf                     #配置目录，可挂载
|   |-- frpc.ini
|   |-- frpc_full.ini
|   |-- frps.ini
|   `-- frps_full.ini
|-- frpc
|-- logs                     #日志目录，可挂载
|-- start_frp.sh             #启动脚本
`-- systemd
    |-- frpc.service
    |-- frpc@.service
    |-- frps.service
    `-- frps@.service
```

## 4.Nginx配置
	nginx配置请参考官方文档：https://hub.docker.com/_/nginx

## 5.运行

获取docker frp
> docker pull loamen/frp:0.37.1

基本运行
> $ docker run --privileged=true --name loamen-frp -d loamen/frp:0.37.1

挂载ngxin目录
```
docker run --privileged=true --name loamen-frp \
	-v /host/path/nginx/html:/usr/share/nginx/html \
	-v /host/path/nginx/conf:/etc/nginx/conf.d \
	-d loamen/frp:0.37.1
```

挂载frp目录
```
docker run --privileged=true --name loamen-frp \
	-v /host/path/frp/conf:/opt/frp/conf \
	-v /host/path/frp/logs:/opt/frp/logs \
	-d loamen/frp:0.37.1
```

挂载nginx和frp目录
```
docker run --privileged=true --name loamen-frp \
	-v /host/path/nginx/html:/usr/share/nginx/html \
	-v /host/path/nginx/conf:/etc/nginx/conf.d \
	-v /host/path/frp/conf:/opt/frp/conf \
	-v /host/path/frp/logs:/opt/frp/logs \
	-d loamen/frp:0.37.1
```

设置环境变量，启动类型`FRP_TYPE`：`client`为客户端模式，`server`为服务端模式
```
docker run --privileged=true --name loamen-frp \
	--env FRP_TYPE=client
	-d loamen/frp:0.37.1
```

全部设置
```
docker run --privileged=true --name loamen-frp \
	--env FRP_TYPE=client \
	-v /host/path/nginx/html:/usr/share/nginx/html \
	-v /host/path/nginx/conf:/etc/nginx/conf.d \
	-v /host/path/frp/conf:/opt/frp/conf \
	-v /host/path/frp/logs:/opt/frp/logs \
	-d loamen/frp:0.37.1
```