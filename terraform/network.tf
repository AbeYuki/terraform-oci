# vcn 01
## Kubernetes node
resource "oci_core_virtual_network" "VCN01" {
  cidr_block     = var.CIDR_VCN01
  compartment_id = var.COMPARTMENT_OCID
  display_name   = "vcn01"
  dns_label      = "vcn01"
}
## Operation node
resource "oci_core_virtual_network" "VCN02" {
  cidr_block     = var.CIDR_VCN02
  compartment_id = var.COMPARTMENT_OCID
  display_name   = "vcn02"
  dns_label      = "vcn02"
}

# subnet
## public
resource "oci_core_subnet" "SUBNET01" {
  availability_domain = lookup(data.oci_identity_availability_domains.ADS.availability_domains[0], "name")
  cidr_block          = var.CIDR_SUBNET01
  display_name        = "subnet01"
  dns_label           = "public"
  security_list_ids   = [oci_core_security_list.SL01.id]
  compartment_id      = var.COMPARTMENT_OCID
  vcn_id              = oci_core_virtual_network.VCN01.id
  route_table_id      = oci_core_route_table.RT01.id
}

## private
resource "oci_core_subnet" "SUBNET02" {
  availability_domain        = lookup(data.oci_identity_availability_domains.ADS.availability_domains[0], "name")
  cidr_block                 = var.CIDR_SUBNET02
  display_name               = "subnet02"
  dns_label                  = "private"
  security_list_ids          = [oci_core_security_list.SL02.id]
  compartment_id             = var.COMPARTMENT_OCID
  vcn_id                     = oci_core_virtual_network.VCN01.id
  route_table_id             = oci_core_route_table.RT02.id
  prohibit_public_ip_on_vnic = true
}

## public
resource "oci_core_subnet" "SUBNET03" {
  availability_domain = lookup(data.oci_identity_availability_domains.ADS.availability_domains[0], "name")
  cidr_block          = var.CIDR_SUBNET03
  display_name        = "subnet03"
  dns_label           = "public"
  security_list_ids   = [oci_core_security_list.SL03.id]
  compartment_id      = var.COMPARTMENT_OCID
  vcn_id              = oci_core_virtual_network.VCN02.id
  route_table_id      = oci_core_route_table.RT03.id
}

# gatway
## internet-gateway
resource "oci_core_internet_gateway" "IG01" {
  compartment_id = var.COMPARTMENT_OCID
  display_name   = "ig01"
  vcn_id         = oci_core_virtual_network.VCN01.id
}
resource "oci_core_internet_gateway" "IG02" {
  compartment_id = var.COMPARTMENT_OCID
  display_name   = "ig02"
  vcn_id         = oci_core_virtual_network.VCN02.id
}
## nat-gateway
resource "oci_core_nat_gateway" "NG01" {
  display_name   = "ng01"
  compartment_id = var.COMPARTMENT_OCID
  vcn_id         = oci_core_virtual_network.VCN01.id
}

# route-table
# default
resource "oci_core_default_route_table" "DEFAULT_RT01" {
  manage_default_resource_id = oci_core_virtual_network.VCN01.default_route_table_id
  route_rules {
    network_entity_id = oci_core_internet_gateway.IG01.id
    destination       = "0.0.0.0/0"
  }
}

## public
resource "oci_core_route_table" "RT01" {
  compartment_id = var.COMPARTMENT_OCID
  vcn_id         = oci_core_virtual_network.VCN01.id
  display_name   = "rt01"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.IG01.id
  }
}
## private
resource "oci_core_route_table" "RT02" {
  compartment_id = var.COMPARTMENT_OCID
  vcn_id         = oci_core_virtual_network.VCN01.id
  display_name   = "rt02"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.NG01.id
  }
}
## public
resource "oci_core_route_table" "RT03" {
  compartment_id = var.COMPARTMENT_OCID
  vcn_id         = oci_core_virtual_network.VCN02.id
  display_name   = "rt03"
  route_rules {
    destination       = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.IG02.id
  }
}



