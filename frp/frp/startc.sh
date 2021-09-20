#!/bin/sh

set -e

echo "开始执行frpc"
#nohup /opt/frp/frpc -c /opt/frp/cnf/frpc.ini  > /opt/frp/logs/client/client.log 2>&1 &
systemctl start nginx
/opt/frp/frpc -c /opt/frp/conf/frpc.ini
echo "执行frpc结束"