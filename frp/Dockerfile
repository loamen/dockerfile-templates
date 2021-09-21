#FROM hub.huima.com/huima/phusion/baseimage:focal-1.0.0
FROM nginx:latest

#定义端口
EXPOSE 80
EXPOSE 443
EXPOSE 7000

#### 配置文件
COPY conf /etc/nginx/conf.d
COPY frp /opt/frp
COPY html /usr/share/nginx/html

WORKDIR /opt/frp



RUN sed -r -i 's/(deb|archive|security)\.debian\.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
  && apt-get update \
  && apt-get install net-tools iputils-ping -y \
  && echo "[Nginx] build OK" \

  && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
  && echo 'Asia/Shanghai' >/etc/timezone \

  # clean
  && rm -rf /tmp/* \
  && apt autoremove -y \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


#定义可被挂载的目录，分别是虚拟机的挂载目录、证书目录、配置目录和日志目录
#VOLUME ["/usr/share/nginx/html","/etc/nginx/certs","/etc/nginx/conf.d","/var/log/nginx"]
VOLUME ["/opt/frp/logs","/opt/frp/conf"]

#ENTRYPOINT ["/opt/frp/startc.sh"]
#CMD ["bash", "-c", "/opt/frp/startc.sh"]