# VPC
variable "vpc_cidr_block" {
  default = "172.31.0.0/16"
}
variable "vpc_enable_dns_hostnames" {
  default = "true"
}
variable "vpc_enable_dns_support" {
  default = "true"
}
# Public Subnets
variable "public_cidrs" {
  description = "Use these CIDRs for subnets"
  type        = "list"
  default     = ["172.31.3.0/24", "172.31.4.0/24"]
}
# Private Subnets
variable "private_cidrs" {
  description = "Use these CIDRs for subnets"
  type        = "list"
  default     = ["172.31.1.0/24", "172.31.2.0/24"]
}
# Bastion
variable "bastion_host" {
  description = "Requered bastion host? true/false"
  default = true
}
variable "bastion_ssh_public_key" {
  description = "Public ssh key for bastion host login"
}
# Change to trusted networks
variable "bastion_ssh_access_cidr" {
  description = "List of cidrs with SSH access to bastion host"
  type        = "list"
  default     = ["0.0.0.0/0"]
}
variable "bastion_instance_type" {
  default     = "t2.micro"
}
variable "bastion_ami" {
  description = "AMI for bastion host, if not defined Latest Amazon Linux 2 will be used"
  default = false
}
# Common
variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type        = "list"
  default     = ["eu-west-1a", "eu-west-1c"]
}
variable "project" {
  default = "platform"
}
variable "environment" {
  default = "production"
}
