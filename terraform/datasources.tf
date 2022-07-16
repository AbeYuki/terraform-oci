data "oci_identity_availability_domains" "ADS" {
  compartment_id = var.COMPARTMENT_OCID
}

data "template_file" "CLOUD_CONFIG_NODE" {
  template = <<YAML
#cloud-config
timezone: Asia/Tokyo
locale: ja_JP.utf8
runcmd:
- apt-get update
- apt-get install -y dnsutils jq
- sysctl -w net.ipv4.ip_forward=1
- sed -i -e "s/^#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf
- iptables -F
- iptables -I FORWARD 1 -i ens3 -o ens3 -j ACCEPT
- iptables -t nat -A POSTROUTING -o ens3 -s ${var.CIDR_SUBNET02} -j MASQUERADE
YAML
}

data "template_file" "CLOUD_CONFIG_BASTION" {
  template = <<YAML
#cloud-config
timezone: Asia/Tokyo
locale: ja_JP.utf8
runcmd:
- apt-get update
- apt-get install -y dnsutils jq
- sysctl -w net.ipv4.ip_forward=1
- sed -i -e "s/^#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf
- iptables -F
- iptables -I FORWARD 1 -i ens3 -o ens3 -j ACCEPT
- iptables -t nat -A POSTROUTING -o ens3 -s ${var.CIDR_SUBNET02} -j MASQUERADE
- sudo -u ubuntu mkdir -p /home/ubuntu/.kube/
YAML
}