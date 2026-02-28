#!/bin/bash
# Cloud-init style script for control plane (Ubuntu 22.04)
set -e
apt update -y
apt install -y containerd apt-transport-https ca-certificates curl software-properties-common

# Configure containerd
mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml || true
systemctl restart containerd || true

# Install Kubernetes packages
curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
add-apt-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
apt update -y
apt install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

# Initialize cluster
kubeadm init --pod-network-cidr=192.168.0.0/16 --ignore-preflight-errors=Swap || true

# Configure kubectl for ubuntu user
mkdir -p /home/ubuntu/.kube
cp -i /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
chown ubuntu:ubuntu /home/ubuntu/.kube/config

# Install Calico CNI (asynchronous)
su - ubuntu -c "kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml" || true

# Save join command for worker nodes
kubeadm token create --print-join-command > /home/ubuntu/join-command.sh || true
chmod +x /home/ubuntu/join-command.sh || true

echo "Control plane provisioning finished" > /var/log/control-plane-user-data.log
