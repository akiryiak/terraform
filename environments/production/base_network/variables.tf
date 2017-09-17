variable "region" {
  default     = "us-west-2"
}
variable "access_key" {
  description = "AWS access key, do not store in VCS"
}
variable "secret_key" {
  description = "AWS secret key, do not store in VCS"
}
variable "environment" {
  default     = "production"
}
variable "s3_state_bucket" {
  default     = ""
}
variable "s3_state_key" {
  default     = "base_network/terraform.tfstate"
}
variable "private_cidrs" {
  description = "Use these CIDRs for subnets"
  type        = "list"
  default     = ["172.31.1.0/24", "172.31.2.0/24"]
}
variable "public_cidrs" {
  description = "Use these CIDRs for subnets"
  type        = "list"
  default     = ["172.31.3.0/24", "172.31.4.0/24"]
}
variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type        = "list"
  default     = ["us-west-2a", "us-west-2c"]
}
variable "ssh_key" {
  description = "Your AWS ssh key name"
  default     = ""
}
