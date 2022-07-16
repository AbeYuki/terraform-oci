# SL01 K8S NODE
resource "oci_core_security_list" "SL01" {
  compartment_id = var.COMPARTMENT_OCID
  vcn_id         = oci_core_virtual_network.VCN01.id
  display_name   = "sl01"
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
    stateless   = false
    description = "all"
  }
  ingress_security_rules {
    source      = "0.0.0.0/0"
    protocol    = "6"
    stateless   = false
    description = "http"
    tcp_options {
      min = "80"
      max = "80"
    }
  }
  ingress_security_rules {
    source      = "0.0.0.0/0"
    protocol    = "6"
    stateless   = false
    description = "https"
    tcp_options {
      min = "443"
      max = "443"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "6"
    stateless   = false
    description = "http"
    tcp_options {
      min = "80"
      max = "80"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "6"
    stateless   = false
    description = "https"
    tcp_options {
      min = "443"
      max = "443"
    }
  }
  ingress_security_rules {
    source      = "${var.MY_GLOBAL_IP}/32"
    protocol    = "6"
    stateless   = false
    description = "etcd"
    tcp_options {
      min = "2379"
      max = "2380"
    }
  }
  ingress_security_rules {
    source      = "${var.MY_GLOBAL_IP}/32"
    protocol    = "6"
    stateless   = false
    description = "kubernetes-api-server"
    tcp_options {
      min = "6443"
      max = "6443"
    }
  }
  ingress_security_rules {
    source      = "${var.MY_GLOBAL_IP}/32"
    protocol    = "6"
    stateless   = false
    description = "NodePort"
    tcp_options {
      min = "30000"
      max = "32767"
    }
  }
  ingress_security_rules {
    source   = var.CIDR_VCN01
    protocol = "6"
    tcp_options {
      min = "53"
      max = "53"
    }
  }
  ingress_security_rules {
    source   = var.CIDR_VCN01
    protocol = "17"
    udp_options {
      min = "53"
      max = "53"
    }
  }
  ingress_security_rules {
    source      = "${var.MY_GLOBAL_IP}/32"
    protocol    = "6"
    stateless   = false
    description = "ssh"
    tcp_options {
      min = "22"
      max = "22"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "6"
    stateless   = false
    description = "etcd"
    tcp_options {
      min = "2376"
      max = "2376"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "6"
    stateless   = false
    description = "etcd server client port"
    tcp_options {
      min = "2379"
      max = "2380"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "17"
    stateless   = false
    description = "Kubernetes UDP"
    udp_options {
      min = "8472"
      max = "8472"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "6"
    stateless   = false
    description = "controlplane"
    tcp_options {
      min = "9099"
      max = "9099"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "6"
    stateless   = false
    description = "etcd"
    tcp_options {
      min = "10250"
      max = "10250"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "6"
    stateless   = false
    description = "controlplane"
    tcp_options {
      min = "10254"
      max = "10254"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "6"
    stateless   = false
    description = "microk8s-kube-controller"
    tcp_options {
      min = "10257"
      max = "10257"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "6"
    stateless   = false
    description = "microk8s-kube-scheduler"
    tcp_options {
      min = "10257"
      max = "10257"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "6"
    stateless   = false
    description = "kubernetes-api-server"
    tcp_options {
      min = "6443"
      max = "6443"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "6"
    stateless   = false
    description = "microk8s-api-server"
    tcp_options {
      min = "16443"
      max = "16443"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "6"
    stateless   = false
    description = "microk8s-dqlite"
    tcp_options {
      min = "19001"
      max = "19001"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "6"
    stateless   = false
    description = "microk8s-cluster-agent"
    tcp_options {
      min = "25000"
      max = "25000"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "6"
    stateless   = false
    description = "nodeport(TCP)"
    tcp_options {
      min = "30000"
      max = "32767"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "17"
    stateless   = false
    description = "nodeport(UDP)"
    udp_options {
      min = "30000"
      max = "32767"
    }
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "all"
    stateless   = false
    description = "all vcn01"
  }
}

# SL02 NFS NODE
resource "oci_core_security_list" "SL02" {
  compartment_id = var.COMPARTMENT_OCID
  vcn_id         = oci_core_virtual_network.VCN01.id
  display_name   = "sl02"
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
    stateless   = false
    description = "all"
  }
  ingress_security_rules {
    source      = var.CIDR_VCN01
    protocol    = "all"
    stateless   = false
    description = "all vcn01"
  }
  ingress_security_rules {
    source    = var.CIDR_VCN01
    protocol  = "6"
    stateless = false
    tcp_options {
      min = "53"
      max = "53"
    }
  }
  ingress_security_rules {
    source    = var.CIDR_VCN01
    protocol  = "6"
    stateless = false
    tcp_options {
      min = "53"
      max = "53"
    }
  }
  ingress_security_rules {
    source    = var.CIDR_VCN01
    protocol  = "17"
    stateless = false
    udp_options {
      min = "53"
      max = "53"
    }
  }
}

# SL03 OPE NODE
resource "oci_core_security_list" "SL03" {
  compartment_id = var.COMPARTMENT_OCID
  vcn_id         = oci_core_virtual_network.VCN02.id
  display_name   = "sl03"
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
    stateless   = false
    description = "all"
  }
  ingress_security_rules {
    source      = "0.0.0.0/0"
    protocol    = "6"
    stateless   = false
    description = "ssh"
    tcp_options {
      min = "22"
      max = "22"
    }
  }
  ingress_security_rules {
    source   = var.CIDR_VCN01
    protocol = "6"
    tcp_options {
      min = "53"
      max = "53"
    }
  }
  ingress_security_rules {
    source   = var.CIDR_VCN01
    protocol = "17"
    udp_options {
      min = "53"
      max = "53"
    }
  }
}