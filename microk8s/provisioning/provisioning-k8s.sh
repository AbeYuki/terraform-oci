#!/bin/bash
sudo iptables -F
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo netfilter-persistent save
sudo hostnamectl set-hostname "$(hostname).public.vcn01.oraclevcn.com"
sudo echo "$(hostname) $(hostname -I | awk '{print $1}')" | sudo tee -a /etc/hosts