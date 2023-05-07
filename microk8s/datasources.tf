data "oci_identity_availability_domains" "ADS" {
  compartment_id = var.COMPARTMENT_OCID
}

data "template_file" "CLOUD_CONFIG" {
  template = <<YAML
#cloud-config
timezone: Asia/Tokyo
locale: ja_JP.utf8
runcmd:
- apt update -y
- apt install -y dnsutils jq
- sysctl -w net.ipv4.ip_forward=1
- sed -i -e "s/^#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf
- iptables -F
- iptables -I FORWARD 1 -i ens3 -o ens3 -j ACCEPT
- iptables -t nat -A POSTROUTING -o ens3 -s ${var.CIDR_SUBNET02} -j MASQUERADE
- curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | tee /usr/share/keyrings/helm.gpg > /dev/null
- apt-get install apt-transport-https --yes
- echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
- apt-get update
- apt-get install helm
- curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.24.0/bin/linux/arm64/kubectl
- chmod +x ./kubectl
- mv ./kubectl /usr/local/bin/kubectl
- sudo -u ubuntu mkdir /home/ubuntu/.kube
- sudo -u ubuntu touch /home/ubuntu/.kube/config
- systemctl enable snapd
- systemctl start snapd
- snap install microk8s --classic --channel latest/stable
- usermod -aG microk8s ubuntu
- sudo -u ubuntu microk8s config | tee /home/ubuntu/.kube/config
YAML
}