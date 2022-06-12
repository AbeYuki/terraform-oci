variable "TENANCY_OCID" {}
variable "USER_OCID" {}
variable "FINGERPRINT" {}
variable "API_KEY" {}
variable "PRIVATE_KEY_PASSWORD" {}
variable "PRIVATE_KEY_INSTANCE" {}
variable "REGION" {
  default = "ap-osaka-1"
}
variable "AVAILABILITY_ZONE" {
  default = "ZMzB:AP-OSAKA-1-AD-1"
}
variable "COMPARTMENT_OCID" {}
variable "SSH_PUBLIC_KEY" {}
variable "INSTANCE_SOURCE_OCID" {
  default = "ocid1.image.oc1.ap-osaka-1.aaaaaaaac7iw6wata2msc5zgjimahmodc3eytg2ki3oxnk3bitmylryjzimq"
}
variable "VOLUME_ATTACHMENT_ATTACHMENT_TYPE" {
  default = "paravirtualized"
}
variable "CIDR_VCN01" {
  default = "192.168.0.0/16"
}
variable "CIDR_SUBNET01" {
  default = "192.168.0.0/24"
}
variable "CIDR_SUBNET02" {
  default = "192.168.1.0/24"
}