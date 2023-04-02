#! /bin/bash

echo "Setting up docker"
sudo su
apt update -y
apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
apt update -y
apt-cache policy docker-ce
apt install -y docker-ce

mkdir /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
systemctl enable --now docker
usermod -aG docker ubuntu
systemctl restart docker

echo "Disabling SWAP"
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sysctl net.bridge.bridge-nf-call-iptables=1
