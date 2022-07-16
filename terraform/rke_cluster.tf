resource "rke_cluster" "cluster" {
  cluster_name          = "oci-rke-cluster"
  disable_port_check    = false
  ignore_docker_version = false
  delay_on_creation     = 10
  addon_job_timeout     = 30
  nodes {
    address          = oci_core_instance.MASTER.0.public_ip
    internal_address = oci_core_instance.MASTER.0.private_ip
    user             = "ubuntu"
    ssh_key          = file(var.PRIVATE_KEY_INSTANCE_PATH)
    role             = ["controlplane", "worker", "etcd"]
  }
  nodes {
    address          = oci_core_instance.NODE.0.public_ip
    internal_address = oci_core_instance.NODE.0.private_ip
    user             = "ubuntu"
    ssh_key          = file(var.PRIVATE_KEY_INSTANCE_PATH)
    role             = ["worker"]
  }
  nodes {
    address          = oci_core_instance.NODE.1.public_ip
    internal_address = oci_core_instance.NODE.1.private_ip
    user             = "ubuntu"
    ssh_key          = file(var.PRIVATE_KEY_INSTANCE_PATH)
    role             = ["worker"]
  }
  authorization {
    mode = "rbac"
  }
  network {
    plugin = "flannel"
  }
  ingress {
    provider = "none"
  }
  monitoring {
    provider = "none"
  }
}
resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/kube_config_cluster.yml"
  content  = rke_cluster.cluster.kube_config_yaml
}