variable "name" {
  default     = "bastion"
}
variable "vpc_id" {
  description = "Declare in ${environment}/main.tf, ex. '${module.vpc.id}'"
}
variable "vpc_cidr" {
  description = "Declare in ${environment}/main.tf, ex. '${module.vpc.cidr}'"
}
variable "public_subnet_ids" {
  description = "Declare in ${environment}/main.tf, ex. '${module.public_subnet.ids}'"
  type        = "list"
}
variable "key_name" {
  default     = ""
}
variable "instance_type" {
  default     = "t2.micro"
}
variable "environment" {
  default     = "production"
}
variable "ami" {
  default     = "ami-aa5ebdd2"
}
#Change to trusted networks
variable "ssh_cidrs" {
  type        = "list"
  default     = ["0.0.0.0/0"]
}
variable "azs" {
  description = "Run the Bastion Instances in these Availability Zones"
  type        = "list"
  default     = ["us-east-1a", "us-east-1c"]
}
