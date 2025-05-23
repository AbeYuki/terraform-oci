terraform {
  backend "s3" {
    bucket  = "aimhighergg-tfstate"
    region  = "ap-northeast-1"
    key     = "oci-rke.tfstate"
    encrypt = true
  }
  required_providers {
    oci = {
      source = "oracle/oci"
      version = "6.34.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
    rke = {
      source  = "rancher/rke"
      version = "1.5.0"
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
  debug    = true
  log_file = "rke_debug.log"
}