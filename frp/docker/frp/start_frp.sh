#!/bin/bash

set -e

if [ "$FRP_TYPE" == "server" ]; then
    echo "frps starting..."
	nohup /opt/frp/frps -c /opt/frp/conf/frps.ini  > /opt/frp/logs/server.log 2>&1 &
	echo "frps started"
else
    echo "frpc starting..."
	nohup /opt/frp/frpc -c /opt/frp/conf/frpc.ini  > /opt/frp/logs/client.log 2>&1 &
	echo "frpc started"
fi