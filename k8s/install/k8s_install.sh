#!/bin/bash

echo "1.更新环境"

sudo apt update
sudo apt -y upgrade 


echo "2.关闭swap分区"

sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a

echo "3.关闭防火墙"

sudo ufw disable

echo "4.设置参数"

sudo modprobe overlay
sudo modprobe br_netfilter

sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system

echo "5.安装docker"

#设置阿里云镜像源
sudo add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update
sudo apt install -y docker.io

# Create required directories
sudo mkdir -p /etc/systemd/system/docker.service.d

# Create daemon json config file
sudo tee /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

# Start and enable Services
sudo systemctl daemon-reload 
sudo systemctl enable docker.service --now
sudo systemctl restart docker
sudo systemctl status docker
docker --version

echo "6.设置 Kubernetes repository"

sudo apt update
sudo apt install -y apt-transport-https curl gnupg2 software-properties-common ca-certificates

#curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add - #使用阿里云

#sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo tee /etc/apt/sources.list.d/kubernetes.list <<EOF 
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main #阿里云源
EOF


echo "7.安装k8s"


sudo apt update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl #标记阻止自动更新

kubectl version --client && kubeadm version