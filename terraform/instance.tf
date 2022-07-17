#arm 4CPU 24G
resource "oci_core_instance" "NODE" {
  count               = 2
  availability_domain = oci_core_subnet.SUBNET02.availability_domain
  compartment_id      = var.COMPARTMENT_OCID
  shape               = lookup(var.SHAPE, "ARM")
  display_name        = "node0${count.index + 1}"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 6
  }
  create_vnic_details {
    subnet_id              = oci_core_subnet.SUBNET01.id
    assign_public_ip       = true
    skip_source_dest_check = false
  }
  source_details {
    source_id   = lookup(var.INSTANCE_SOURCE_OCID, "ARM")
    source_type = "image"
  }
  metadata = {
    ssh_authorized_keys = "${file(var.SSH_PUBLIC_KEY_PATH)}"
    user_data           = "${base64encode(data.template_file.CLOUD_CONFIG_NODE.rendered)}"
  }
  timeouts {
    create = "60m"
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.OS_USER
      host        = self.public_ip
      private_key = file(var.PRIVATE_KEY_INSTANCE_PATH)
      timeout     = "5m"
    }
    scripts = [
      "provisioning/provisioning.sh",
    ]
  }
}
resource "oci_core_instance" "MASTER" {
  count               = 1
  availability_domain = oci_core_subnet.SUBNET02.availability_domain
  compartment_id      = var.COMPARTMENT_OCID
  shape               = lookup(var.SHAPE, "ARM")
  display_name        = "master0${count.index + 1}"

  shape_config {
    ocpus         = 2
    memory_in_gbs = 12
  }

  create_vnic_details {
    subnet_id              = oci_core_subnet.SUBNET01.id
    assign_public_ip       = true
    skip_source_dest_check = false
  }
  source_details {
    source_id   = lookup(var.INSTANCE_SOURCE_OCID, "ARM")
    source_type = "image"
  }
  metadata = {
    ssh_authorized_keys = "${file(var.SSH_PUBLIC_KEY_PATH)}"
    user_data           = "${base64encode(data.template_file.CLOUD_CONFIG_NODE.rendered)}"
  }
  timeouts {
    create = "60m"
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.OS_USER
      host        = self.public_ip
      private_key = file(var.PRIVATE_KEY_INSTANCE_PATH)
      timeout     = "5m"
    }
    scripts = [
      "provisioning/provisioning.sh",
    ]
  }
}

resource "oci_core_instance" "BASTION" {
  count               = 1
  availability_domain = oci_core_subnet.SUBNET01.availability_domain
  compartment_id      = var.COMPARTMENT_OCID
  shape               = lookup(var.SHAPE, "AMD")
  display_name        = "bastion0${count.index + 1}"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 1
  }

  create_vnic_details {
    subnet_id              = oci_core_subnet.SUBNET01.id
    assign_public_ip       = true
    skip_source_dest_check = false
  }
  source_details {
    source_id   = lookup(var.INSTANCE_SOURCE_OCID, "AMD")
    source_type = "image"
  }
  metadata = {
    ssh_authorized_keys = "${file(var.SSH_PUBLIC_KEY_PATH)}"
    private_key         = "${file(var.PRIVATE_KEY_INSTANCE_PATH)}"
    user_data           = "${base64encode(data.template_file.CLOUD_CONFIG_BASTION.rendered)}"
  }
  timeouts {
    create = "60m"
  }
  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = var.OS_USER
      host        = self.public_ip
      private_key = file(var.PRIVATE_KEY_INSTANCE_PATH)
      timeout     = "5m"
    }
    scripts = [
      "provisioning/install.sh",
    ]
  }
}

output "private_ips" {
  value       = [
    oci_core_instance.BASTION.*.private_ip,
    oci_core_instance.MASTER.*.private_ip,
    oci_core_instance.NODE.*.private_ip
  ]
  description = "Private IPs of instances"
}

output "public_ips" {
  value       = [
    oci_core_instance.BASTION.*.public_ip,
    oci_core_instance.MASTER.*.public_ip,
    oci_core_instance.NODE.*.public_ip
  ]
  description = "Public IPs of instances"
}
