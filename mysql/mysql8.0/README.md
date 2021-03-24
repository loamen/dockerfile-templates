## 一、什么是 Dockerfile？
Dockerfile 是一个用来构建镜像的文本文件，文本内容包含了一条条构建镜像所需的指令和说明。
这里不讲Dockerfile的指令，可自行百度。

## 二、创建MySql的Dockerfile
创建基于8.0.30版本的MySql，编写Dockerfile文件具体如下：
```
#创建一个基于8.0.30版本的MySql
FROM mysql:8.0.30 

MAINTAINER don
EXPOSE 3306
LABEL version="0.1" description="Mysql服务器" by="don"

#设置免密登录
ENV MYSQL_ALLOW_EMPTY_PASSWORD yes

#将所需文件放到容器中
COPY /mysql/setup.sh /mysql/setup.sh #拷贝安装脚本
COPY /mysql/create_db.sql /mysql/create_db.sql #创建数据库
COPY /mysql/initial_data.sql /mysql/initial_data.sql #初始数据
COPY /mysql/privileges.sql /mysql/privileges.sql #设置密码和权限

#设置容器启动时执行的命令
#CMD ["sh", "/mysql/setup.sh"]
```
## 三、构建MySql的Dockerfile
使用`docker build`命令构建刚才创建的`Dockerfile`文件，这里一定要注意最后面有个`.`，`--no-cache=true`表示禁用缓存。
> docker build -f Dockerfile -t loamen-mysql:8.0 --no-cache=true .

如果是在Windows环境下构建，可能会出现如下提示：
```
SECURITY WARNING: You are building a Docker image from Windows against a non-Windows Docker host. All files and directories added to build context will have '-rwxr-xr-x' permissions. It is recommended to double check and reset permissions for sensitive files and directories.
```
该提示表示Windows构建出来的拥有所有权限，如果不需要那么多可以使用`-rwxr-xr-x`修改，如果不需要修改权限可以忽略。

执行成功后可以通过`docker images`查看刚才生成的镜像，这里可以看到多了`loamen-mysql`的镜像
```
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
loamen-mysql        8.0                 4da21faea397        2 minutes ago       449MB
mysql               8.0.30              9cfcce23593a        4 weeks ago         448MB
```

## 四、运行mysql容器
使用`docker run`命令来运行容器，这里使用了`-v`挂载本地卷，但没有使用`-e MYSQL_ROOT_PASSWORD=123456`来设置密码，是因为这里要使用空密码创建初始数据。
>docker run --privileged=true --name loamen-mysql -p 3306:3306 -v /my/mysql/data:/var/lib/mysql -v /my/mysql/conf.d:/etc/mysql/conf.d -v /my/mysql/logs:/var/log/mysql -d loamen-mysql:8.0

运行好后使用`docker ps`来查看刚才创建的容器
```
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                               NAMES
bd285ecb867a        loamen-mysql:8.0    "docker-entrypoint.s…"   4 seconds ago       Up 4 seconds        0.0.0.0:3306->3306/tcp, 33060/tcp   loamen-mysql
```

## 五、其他操作
进入容器`bash`，这里`spaceon-mysql`使用`CONTAINER ID`值`bd285ecb867a`也可以。
>docker exec -it spaceon-mysql /bin/bash

删除容器，`-f`表示强制删除，如果不强制删除可以使用`docker stop`先停止容器，`-v`表示连本地卷一起删除。
>docker rm -f loamen-mysql -v

删除镜像
>docker rmi loamen-mysql:8.0

## 六、脚本内容
`setup.sh`初始化运行脚本如下
```
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
```
`create_db`脚本内容如下
```
USE mysql;
CREATE DATABASE IF NOT EXISTS spaceon_gms;
```

`create_db.sql`脚本内容如下
```
--使用默认数据库
USE mysql;
-- 创建一个名为loamen_demo的数据库
CREATE DATABASE IF NOT EXISTS loamen_demo;
```

`initial_data.sql`脚本内容如下
```
--使用默认数据库
--不要忘记初始化到哪个数据库
USE loamen_demo;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

--其他数据库初始化脚本
...
```

`privileges.sql`脚本内容如下
```
use mysql;
SELECT host, user FROM user;

-- 将数据库的权限授权给root用户，密码为123456：
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123456';

-- 刷新权限这一条命令一定要有：
flush privileges;
```
如果是Windows下创建的脚本文件，请使用`utf-8`编码，如果到Linux中运行依然乱码，可以使用如下命令进行转换
>sed -i "s/\r//" create_db.sql 

## 七、源码
[https://github.com/loamen/dockerfile-templates](https://github.com/loamen/dockerfile-templates)