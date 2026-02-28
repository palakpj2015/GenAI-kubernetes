#!/bin/bash
set -eux

apt-get update
apt-get install -y ca-certificates curl gnupg lsb-release

# Install containerd
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y containerd.io
cat <<EOF >/etc/containerd/config.toml
[plugins]
  [plugins."io.containerd.grpc.v1.cri".containerd]
    snapshotter = "overlayfs"
EOF
systemctl restart containerd

# Install kubeadm and kubelet
curl -fsSL https://apt.kubernetes.io/ | apt-key add - || true
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubeadm kubelet
apt-mark hold kubeadm kubelet

# Worker will join via SSM or manual execution of /home/ubuntu/join-command.sh
