#!/bin/bash

echo "修改docker普通用户权限"
sudo chmod 777 /var/run/docker.sock

echo "1.拉取镜像"

#下面的版本号要对应
KUBE_VERSION=v1.22.2
PAUSE_VERSION=3.5
CORE_DNS_VERSION=1.8.4
ETCD_VERSION=3.5.0-0

# pull kubernetes images from hub.docker.com
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy-amd64:$KUBE_VERSION
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager-amd64:$KUBE_VERSION
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver-amd64:$KUBE_VERSION
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler-amd64:$KUBE_VERSION
# pull aliyuncs mirror docker images
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/pause:$PAUSE_VERSION
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:$CORE_DNS_VERSION
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:$ETCD_VERSION

# retag to k8s.gcr.io prefix
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy-amd64:$KUBE_VERSION  k8s.gcr.io/kube-proxy:$KUBE_VERSION
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager-amd64:$KUBE_VERSION k8s.gcr.io/kube-controller-manager:$KUBE_VERSION
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver-amd64:$KUBE_VERSION k8s.gcr.io/kube-apiserver:$KUBE_VERSION
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler-amd64:$KUBE_VERSION k8s.gcr.io/kube-scheduler:$KUBE_VERSION
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/pause:$PAUSE_VERSION k8s.gcr.io/pause:$PAUSE_VERSION
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:$CORE_DNS_VERSION k8s.gcr.io/coredns/coredns:v$CORE_DNS_VERSION
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:$ETCD_VERSION k8s.gcr.io/etcd:$ETCD_VERSION

# untag origin tag, the images won't be delete.
docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy-amd64:$KUBE_VERSION
docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager-amd64:$KUBE_VERSION
docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver-amd64:$KUBE_VERSION
docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler-amd64:$KUBE_VERSION
docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/pause:$PAUSE_VERSION
docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:$CORE_DNS_VERSION
docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:$ETCD_VERSION

echo "====================执行完毕======================"

echo "所需镜像:"
kubeadm config images list

echo "已安装镜像:"
sudo docker images

echo "====如果数量不匹配请多执行几次k8s_pull_images.sh====="