#!/bin/bash

echo "1.启用k8s"
sudo systemctl enable kubelet
lsmod | grep br_netfilter

echo -e "\n\n"
echo "2.初始化master节点"
echo "============="
echo -e "\033[31m 请输入master节点的HostName: \033[0m"
read hostName

echo -e "\033[32m 执行初始化：sudo kubeadm init --pod-network-cidr 10.5.0.0/16 --control-plane-endpoint=$hostName \033[0m"
sudo kubeadm init --pod-network-cidr 10.5.0.0/16 --control-plane-endpoint=$hostName
#sudo kubeadm init --pod-network-cidr 10.5.0.0/16

sleep 10

echo "3.master节点配置"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
#sudo export KUBECONFIG=/etc/kubernetes/admin.conf

sleep 10

echo "\n\n=================\n\n"
echo "4.初始化网络（选取一种执行）"

echo "安装flannel网络插件"
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
sleep 3
#curl -C- -fLO --retry 3 https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
#sleep 3
#kubectl apply -f kube-flannel-rbac.yml

echo "calico网络插件"
echo "kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml"
echo -e "kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/install\n\n\n"

echo "kubectl cluster-info"
kubectl cluster-info

sleep 3
echo "执行：watch kubectl get pods --all-namespaces"
watch kubectl get pods --all-namespaces