FROM hub.c.163.com/library/mysql:8.0

MAINTAINER loamen
EXPOSE 3306
LABEL version="0.1" description="Mysql服务器" by="loamen"

#设置免密登录
#ENV MYSQL_ALLOW_EMPTY_PASSWORD yes

#将所需文件放到容器中
COPY /mysql/setup.sh /mysql/setup.sh
COPY /mysql/create_db.sql /mysql/create_db.sql
COPY /mysql/initial_data.sql /mysql/initial_data.sql
COPY /mysql/privileges.sql /mysql/privileges.sql


#设置容器启动时执行的命令
# CMD ["sh", "/mysql/setup.sh"]