#!/bin/bash
# Cloud-init style script for worker node (Ubuntu 22.04)
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
apt install -y kubelet kubeadm
apt-mark hold kubelet kubeadm

# NOTE: Replace the placeholder below with the real join command from the control plane.
# Example (do not include the leading #):
# kubeadm join <CONTROL_PLANE_PRIVATE_IP>:6443 --token <TOKEN> --discovery-token-ca-cert-hash <HASH>

echo "Worker node provisioning finished" > /var/log/worker-user-data.log
