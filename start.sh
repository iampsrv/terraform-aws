#!/bin/bash
sudo apt update -y
sudo apt-get update
sudo apt-get -y upgrade
sudo apt install python3
sudo apt install git
git clone https://github.com/iampsrv/flask-app-aws.git
cd flask-app-aws
sudo apt-get -y install python3-pip
pip install -r req.txt
# python3 main.py

echo "Setting up docker"
sudo su
apt update -y
apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" -y
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
docker pull hello-world
docker pull psrv3/newfa
docker run -it -p 5001:5001 psrv3/newfa
