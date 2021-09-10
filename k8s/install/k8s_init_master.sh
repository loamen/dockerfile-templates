#!/bin/bash

echo "1.启用k8s"
sudo systemctl enable kubelet
lsmod | grep br_netfilter

echo "2.初始化master节点"
sudo kubeadm init --pod-network-cidr 10.5.0.0/16 --control-plane-endpoint=vm-ubuntu-06
#sudo kubeadm init --pod-network-cidr 10.5.0.0/16

echo "3.master节点配置"
#mkdir -p $HOME/.kube
#sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config
#sudo echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> /etc/profile
export KUBECONFIG=/etc/kubernetes/admin.conf

echo "4.手动初始化网络（选取一种执行）"

echo "flannel网络插件"
echo "kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml"
echo "kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml"

echo "calico网络插件"
echo "kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/rbac-kdd.yaml"
echo "kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/install"

kubectl cluster-info
echo "kubectl cluster-info"
echo "kubectl get pods --all-namespaces"