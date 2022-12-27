#!/bin/bash
if [ $(uname -i) = aarch64 ]; then
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.24.0/bin/linux/arm64/kubectl
elif [ $(uname -i) = x86_64 ]; then
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.24.0/bin/linux/amd64/kubectl
fi
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
sudo iptables -F
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo netfilter-persistent save