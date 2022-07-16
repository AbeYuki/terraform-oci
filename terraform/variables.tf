variable "TENANCY_OCID" {}
variable "COMPARTMENT_OCID" {}
variable "USER_OCID" {}
variable "FINGERPRINT" {}
variable "API_KEY_PATH" {}
variable "PRIVATE_KEY_INSTANCE_PATH" {}
variable "SSH_PUBLIC_KEY_PATH" {}
variable "MY_GLOBAL_IP" {}
variable "REGION" {
  default = "ap-osaka-1"
}
variable "AVAILABILITY_ZONE" {
  default = "ZMzB:AP-OSAKA-1-AD-1"
}
variable "SHAPE" {
  default = {
    AMD = "VM.Standard.E2.1.Micro"
    ARM = "VM.Standard.A1.Flex"
  }
}
variable "INSTANCE_SOURCE_OCID" {
  default = {
    AMD = "ocid1.image.oc1.ap-osaka-1.aaaaaaaa4lucxlnba6vpf76reg2x6gfxc7pttromfervverqp3r5ymjz2icq"
    ARM = "ocid1.image.oc1.ap-osaka-1.aaaaaaaac7iw6wata2msc5zgjimahmodc3eytg2ki3oxnk3bitmylryjzimq"
  }
}

variable "VOLUME_ATTACHMENT_ATTACHMENT_TYPE" {
  default = "paravirtualized"
}
variable "CIDR_VCN01" {
  default = "10.0.0.0/16"
}
variable "CIDR_SUBNET01" {
  default = "10.0.0.0/24"
}
variable "CIDR_SUBNET02" {
  default = "10.0.1.0/24"
}
variable "CIDR_VCN02" {
  default = "192.168.0.0/16"
}
variable "CIDR_SUBNET03" {
  default = "192.168.0.0/24"
}
variable "OS_USER" {
  default = "ubuntu"
}
variable "DNS_LABEL" {
  default = "k8s.com"
}