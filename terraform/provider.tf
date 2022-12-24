terraform {
  required_providers {
    oci = {
      source  = "oracle/oci"
      version = "4.102.0"
    }
    rke = {
      source  = "rancher/rke"
      version = "1.3.1"
    }
  }
}
provider "oci" {
  tenancy_ocid     = var.TENANCY_OCID
  user_ocid        = var.USER_OCID
  fingerprint      = var.FINGERPRINT
  private_key_path = var.API_KEY_PATH
  region           = var.REGION
}
provider "rke" {
  debug = true
}