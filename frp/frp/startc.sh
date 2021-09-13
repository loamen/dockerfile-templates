#!/bin/sh
nohup /opt/frp/frpc -c /opt/frp/conf/frpc.ini  > client.log 2>&1 &
