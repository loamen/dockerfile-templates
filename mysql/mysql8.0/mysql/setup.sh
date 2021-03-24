#!/bin/bash
set -e


echo '1.创建数据库...'
mysql -uroot -p123456 < /mysql/create_db.sql
sleep 3
echo '2.创建数据库完毕...'


echo '3.开始导入数据...'
mysql -uroot -p123456 < /mysql/initial_data.sql
echo '4.导入数据完毕...'

echo '5.修改mysql权限...'
mysql -uroot -p123456 < /mysql/privileges.sql
sleep 3
echo '6.权限修改完毕...'

#sleep 3
echo 'mysql容器启动完毕,且数据导入成功'

tail -f /dev/null