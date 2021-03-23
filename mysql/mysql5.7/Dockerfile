FROM mysql:5.7.30

MAINTAINER don
EXPOSE 3306
LABEL version="0.1" description="Mysql服务器" by="don"

#设置免密登录
ENV MYSQL_ALLOW_EMPTY_PASSWORD yes

#将所需文件放到容器中
COPY /mysql/setup.sh /mysql/setup.sh
COPY /mysql/create_db.sql /mysql/create_db.sql
COPY /mysql/initial_data.sql /mysql/initial_data.sql
COPY /mysql/privileges.sql /mysql/privileges.sql

#apt-get源 使用163的源
#RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
# echo "deb http://mirrors.163.com/debian/ stretch main non-free contrib" >/etc/apt/sources.list && \
# echo "deb http://mirrors.163.com/debian/ stretch-updates main non-free contrib" >>/etc/apt/sources.list && \
# echo "deb http://mirrors.163.com/debian/ stretch-backports main non-free contrib" >>/etc/apt/sources.list && \
# echo "deb-src http://mirrors.163.com/debian/ stretch main non-free contrib" >>/etc/apt/sources.list && \
# echo "deb-src http://mirrors.163.com/debian/ stretch-updates main non-free contrib" >>/etc/apt/sources.list && \
# echo "deb-src http://mirrors.163.com/debian/ stretch-backports main non-free contrib" >>/etc/apt/sources.list && \
# echo "deb http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib" >>/etc/apt/sources.list && \
# echo "deb-src http://mirrors.163.com/debian-security/ stretch/updates main non-free contrib" >>/etc/apt/sources.list

# RUN apt-get update

#安装vim
#RUN apt-get install -y --allow-remove-essential libtinfo5 && apt-get install -y vim

#设置容器启动时执行的命令
CMD ["sh", "/mysql/setup.sh"]