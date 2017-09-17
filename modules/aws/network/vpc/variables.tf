variable "cidr_block" {
  default = "172.31.0.0/16"
}
variable "vpc_enable_dns_hostnames" {
  default = "true"
}
variable "vpc_enable_dns_support" {
  default = "true"
}
variable "vpc_name" {
  default = "main"
}
variable "vpc_environment" {
  default = "production"
}
