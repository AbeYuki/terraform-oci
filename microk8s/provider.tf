terraform {
  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = ">= 4.80.1"
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
