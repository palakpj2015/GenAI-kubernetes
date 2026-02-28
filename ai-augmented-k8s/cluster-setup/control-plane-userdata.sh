#!/bin/bash
set -eux

# Install prerequisites and containerd
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

# Install kubeadm, kubelet, kubectl
curl -fsSL https://apt.kubernetes.io/ | apt-key add - || true
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y kubeadm kubelet kubectl
apt-mark hold kubeadm kubelet kubectl

# Initialize control plane
kubeadm init --pod-network-cidr=192.168.0.0/16 --apiserver-advertise-address=$(hostname -I | awk '{print $1}') | tee /root/kubeadm-init.out

# Copy kubeconfig for ubuntu
mkdir -p /home/ubuntu/.kube
cp -i /etc/kubernetes/admin.conf /home/ubuntu/.kube/config
chown ubuntu:ubuntu /home/ubuntu/.kube/config

# Install Calico
su - ubuntu -c "kubectl apply -f https://docs.projectcalico.org/manifests/calico.yaml"

# Save the join command for workers
kubeadm token create --print-join-command > /home/ubuntu/join-command.sh
chown ubuntu:ubuntu /home/ubuntu/join-command.sh
chmod +x /home/ubuntu/join-command.sh

# signal complete (cloud-init compatible)
touch /var/log/cluster-setup-complete
