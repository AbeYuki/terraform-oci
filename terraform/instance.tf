resource "oci_core_instance" "K8S" {
  count               = 4
  availability_domain = oci_core_subnet.SUBNET01.availability_domain
  compartment_id      = var.COMPARTMENT_OCID
  shape               = "VM.Standard.A1.Flex"
  display_name        = "node0${count.index + 1}"

  shape_config {
    ocpus         = 1
    memory_in_gbs = 6
  }

  create_vnic_details {
    subnet_id = oci_core_subnet.SUBNET01.id
    assign_public_ip          = true
    skip_source_dest_check    = true
    assign_private_dns_record = true
   # hostname_label            = "node0${count.index + 1}"
  }
  source_details {
    source_id   = var.INSTANCE_SOURCE_OCID
    source_type = "image"
  }
  metadata = {
    ssh_authorized_keys = "${file(var.SSH_PUBLIC_KEY_PATH)}"
    user_data           = "${base64encode(data.template_file.CLOUD_CONFIG.rendered)}"
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

output "public_ips" {
  value       = oci_core_instance.K8S.*.public_ip
  description = "Public IPs of instances"
}

output "private_ips" {
  value       = oci_core_instance.K8S.*.private_ip
  description = "Private IPs of instances"
}