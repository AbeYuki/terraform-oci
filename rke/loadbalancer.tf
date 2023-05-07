resource "oci_network_load_balancer_network_load_balancer" "EXTERNAL_NLB" {
    compartment_id = var.COMPARTMENT_OCID
    display_name = var.NLB_NAME
    is_preserve_source_destination = "false"
    is_private = false
    nlb_ip_version = "IPV4"
    subnet_id = oci_core_subnet.SUBNET01.id
}

resource oci_network_load_balancer_backend_set EXTERNAL_NLB_BACKENDSET {
  health_checker {
    interval_in_millis = "10000"
    port               = "22"
    protocol           = "TCP"
    request_data       = ""
    response_data = ""
    retries       = "3"
    timeout_in_millis = "3000"
  }
  ip_version               = "IPV4"
  is_preserve_source       = "true"
  name                     = "external-nlb-backendset"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.EXTERNAL_NLB.id
  policy                   = "FIVE_TUPLE"
}

resource oci_network_load_balancer_backend MASTER1 {
  backend_set_name         = oci_network_load_balancer_backend_set.EXTERNAL_NLB_BACKENDSET.name
  ip_address               = oci_core_instance.MASTER[0].private_ip
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.EXTERNAL_NLB.id
  port                     = "0"
  weight                   = "1"
}

resource oci_network_load_balancer_backend NODE1 {
  backend_set_name         = oci_network_load_balancer_backend_set.EXTERNAL_NLB_BACKENDSET.name
  ip_address               = oci_core_instance.NODE[0].private_ip
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.EXTERNAL_NLB.id
  port                     = "0"
  weight                   = "1"
}

resource oci_network_load_balancer_backend NODE2 {
  backend_set_name         = oci_network_load_balancer_backend_set.EXTERNAL_NLB_BACKENDSET.name
  ip_address               = oci_core_instance.NODE[1].private_ip
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.EXTERNAL_NLB.id
  port                     = "0"
  weight                   = "1"
}


resource oci_network_load_balancer_listener EXTERNAL_NLB_LITSNER {
  default_backend_set_name = oci_network_load_balancer_backend_set.EXTERNAL_NLB_BACKENDSET.name
  ip_version               = "IPV4"
  name                     = "listener-k8s"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.EXTERNAL_NLB.id
  port                     = "0"
  protocol                 = "TCP"
}

