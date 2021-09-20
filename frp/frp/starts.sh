#!/bin/sh
nohup /opt/frp/frps -c /opt/frp/conf/frps.ini  > /opt/frp/logs/server/server.log 2>&1 &
