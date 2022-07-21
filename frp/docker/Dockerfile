FROM nginx:latest

MAINTAINER don

#定义端口
#EXPOSE 80
#EXPOSE 443
#EXPOSE 7000

#### 配置文件
COPY nginx/conf /etc/nginx/conf.d
COPY nginx/html /usr/share/nginx/html
COPY frp /opt/frp

#设置工作目录
WORKDIR /opt/frp


#设置环境变量，client客户端模式，server服务端模式。默认是客户端模式
ENV FRP_TYPE="client"


RUN sed -r -i 's/(deb|archive|security)\.debian\.org/mirrors.aliyun.com/g' /etc/apt/sources.list
RUN apt-get update
RUN apt-get install net-tools iputils-ping -y
RUN echo "[Nginx] build OK"

#设置时区
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo 'Asia/Shanghai' >/etc/timezone

# clean
RUN rm -rf /tmp/*
RUN apt-get autoremove -y
RUN apt-get clean 
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#定义可被挂载的目录，分别是虚拟机的配置目录和日志目录
VOLUME ["/opt/frp/logs","/opt/frp/conf"]

#ENTRYPOINT ["/opt/frp/start_frp.sh"]
#CMD ["bash", "-c", "/opt/frp/start_frp.sh"]