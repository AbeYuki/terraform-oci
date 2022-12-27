resource "rke_cluster" "cluster" {
  cluster_name          = "oci-rke-cluster"
  kubernetes_version    = "v1.23.10-rancher1-1"
  enable_cri_dockerd    = true
  ignore_docker_version = true
  disable_port_check    = true
  delay_on_creation     = 120
  addon_job_timeout     = 60
  nodes {
    address           = oci_core_instance.MASTER.0.public_ip
    internal_address  = oci_core_instance.MASTER.0.private_ip
    user              = "ubuntu"
    ssh_key           = file(var.PRIVATE_KEY_INSTANCE_PATH)
    role              = ["controlplane", "worker", "etcd"]
  }
  nodes {
    address           = oci_core_instance.NODE.0.public_ip
    internal_address  = oci_core_instance.NODE.0.private_ip
    user              = "ubuntu"
    ssh_key           = file(var.PRIVATE_KEY_INSTANCE_PATH)
    role              = ["worker", "etcd"]
  }
  nodes {
    address           = oci_core_instance.NODE.1.public_ip
    internal_address  = oci_core_instance.NODE.1.private_ip
    user              = "ubuntu"
    ssh_key           = file(var.PRIVATE_KEY_INSTANCE_PATH)
    role              = ["worker", "etcd"]
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
  upgrade_strategy {
    drain                        = true
    max_unavailable_worker       = "20%"
    max_unavailable_controlplane = "1"
  }
}


resource "local_file" "kube_cluster_yaml" {
  filename = "${path.root}/kube_config_cluster.yml"
  content  = rke_cluster.cluster.kube_config_yaml
}

resource "local_file" "rke_cluster_yaml" {
  filename = "${path.root}/cluster.yml"
  content  = rke_cluster.cluster.rke_cluster_yaml
}

resource "local_file" "rke_state" {
  filename = "${path.root}/cluster.rkestate"
  content  = rke_cluster.cluster.rke_state
}