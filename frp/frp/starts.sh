#!/bin/sh
nohup /opt/frp/frps -c /opt/frp/conf/frps.ini  > server.log 2>&1 &
