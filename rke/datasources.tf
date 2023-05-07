data "oci_identity_availability_domains" "ADS" {
  compartment_id = var.COMPARTMENT_OCID
}

data "template_file" "CLOUD_CONFIG_NODE" {
  template = <<YAML
#cloud-config
timezone: Asia/Tokyo
locale: en_US.utf8
runcmd:
- sudo -u ubuntu curl https://releases.rancher.com/install-docker/20.10.sh | sh
- usermod -a -G docker ubuntu
- apt-get install -y dnsutils jq open-iscsi nfs-common
YAML
}

data "template_file" "CLOUD_CONFIG_BASTION" {
  template = <<YAML
#cloud-config
timezone: Asia/Tokyo
locale: en_US.utf8
runcmd:
- apt-get update
- apt-get install -y dnsutils jq unzip
- sudo -u ubuntu mkdir -p /home/ubuntu/.kube/
YAML
}