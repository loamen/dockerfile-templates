#!/bin/sh

set -e

echo "开始执行frps"
nohup /opt/frp/frps -c /opt/frp/conf/frps.ini  > /opt/frp/logs/server/server.log 2>&1 &
echo "执行frps结束"
