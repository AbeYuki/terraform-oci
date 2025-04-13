resource "oci_network_load_balancer_network_load_balancer" "EXTERNAL_NLB" {
  compartment_id                 = var.COMPARTMENT_OCID
  display_name                   = var.NLB_NAME
  is_preserve_source_destination = "false"
  is_private                     = false
  nlb_ip_version                 = "IPV4"
  subnet_id                      = oci_core_subnet.SUBNET01.id
}

# Backend Sets
resource "oci_network_load_balancer_backend_set" "http" {
  name                     = "http-backendset"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.EXTERNAL_NLB.id
  policy                   = "FIVE_TUPLE"
  ip_version               = "IPV4"
  is_preserve_source       = true

  health_checker {
    protocol           = "TCP"
    port               = 30280
    retries            = 3
    timeout_in_millis  = 3000
    interval_in_millis = 10000
  }
}
resource "oci_network_load_balancer_backend_set" "https" {
  name                     = "https-backendset"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.EXTERNAL_NLB.id
  policy                   = "FIVE_TUPLE"
  ip_version               = "IPV4"
  is_preserve_source       = true

  health_checker {
    protocol           = "TCP"
    port               = 30280
    retries            = 3
    timeout_in_millis  = 3000
    interval_in_millis = 10000
  }
}

# Backends master01
resource "oci_network_load_balancer_backend" "master01_http" {
  backend_set_name         = oci_network_load_balancer_backend_set.http.name
  ip_address               = oci_core_instance.MASTER[0].private_ip
  port                     = 31080
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.EXTERNAL_NLB.id
  weight                   = 1
}
resource "oci_network_load_balancer_backend" "master01_https" {
  backend_set_name         = oci_network_load_balancer_backend_set.https.name
  ip_address               = oci_core_instance.MASTER[0].private_ip
  port                     = 31443
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.EXTERNAL_NLB.id
  weight                   = 1
}

# Backends node1
resource "oci_network_load_balancer_backend" "node01_http" {
  backend_set_name         = oci_network_load_balancer_backend_set.http.name
  ip_address               = oci_core_instance.NODE[0].private_ip
  port                     = 31080
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.EXTERNAL_NLB.id
  weight                   = 1
}
resource "oci_network_load_balancer_backend" "node01_https" {
  backend_set_name         = oci_network_load_balancer_backend_set.https.name
  ip_address               = oci_core_instance.NODE[0].private_ip
  port                     = 31443
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.EXTERNAL_NLB.id
  weight                   = 1
}


# Backends node2
resource "oci_network_load_balancer_backend" "node02_http" {
  backend_set_name         = oci_network_load_balancer_backend_set.http.name
  ip_address               = oci_core_instance.NODE[1].private_ip
  port                     = 31080
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.EXTERNAL_NLB.id
  weight                   = 1
}
resource "oci_network_load_balancer_backend" "node02_https" {
  backend_set_name         = oci_network_load_balancer_backend_set.https.name
  ip_address               = oci_core_instance.NODE[1].private_ip
  port                     = 31443
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.EXTERNAL_NLB.id
  weight                   = 1
}



# Listeners
resource "oci_network_load_balancer_listener" "http" {
  name                     = "http"
  port                     = 80
  protocol                 = "TCP"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.EXTERNAL_NLB.id
  default_backend_set_name = oci_network_load_balancer_backend_set.http.name
  depends_on = [
    oci_network_load_balancer_backend_set.http,
    oci_network_load_balancer_backend.master01_http,
    oci_network_load_balancer_backend.node01_http,
    oci_network_load_balancer_backend.node02_http
  ]
}
resource "oci_network_load_balancer_listener" "https" {
  name                     = "https"
  port                     = 443
  protocol                 = "TCP"
  network_load_balancer_id = oci_network_load_balancer_network_load_balancer.EXTERNAL_NLB.id
  default_backend_set_name = oci_network_load_balancer_backend_set.https.name
  depends_on = [
    oci_network_load_balancer_backend_set.http,
    oci_network_load_balancer_backend.master01_http,
    oci_network_load_balancer_backend.node01_http,
    oci_network_load_balancer_backend.node02_http
  ]
}
