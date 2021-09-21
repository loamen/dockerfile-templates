#!/bin/sh

set -e

if [ "$FRP_TYPE" == 'server' ]; then
    echo "开始执行frps"
	nohup /opt/frp/frps -c /opt/frp/conf/frps.ini  > /opt/frp/logs/server.log 2>&1 &
	echo "执行frps结束"
else
    echo "开始执行frpc"
	nohup /opt/frp/frpc -c /opt/frp/conf/frpc.ini  > /opt/frp/logs/client.log 2>&1 &
	echo "执行frpc结束"
fi