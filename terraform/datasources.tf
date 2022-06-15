data "oci_identity_availability_domains" "ads" {
  compartment_id = var.COMPARTMENT_OCID
}

data "template_file" "CLOUD_CONFIG" {
  template = <<YAML
#cloud-config
runcmd:
- sudo apt update -y
- sudo apt install -y dnsutils
- sudo sysctl -w net.ipv4.ip_forward=1
- sudo sed -i -e "s/^#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf
- sudo iptables -F
- sudo iptables -I FORWARD 1 -i ens3 -o ens3 -j ACCEPT
- sudo iptables -t nat -A POSTROUTING -o ens3 -s ${var.CIDR_SUBNET02} -j MASQUERADE
- sudo systemctl enable snapd
- sudo systemctl start snapd
- sudo snap install microk8s --classic --channel latest/stable
- sudo usermod -aG microk8s ${var.OS_USER}
YAML
}