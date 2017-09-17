variable "name" {
  default     = "private"
}
variable "vpc_id" {
  description = "Declare in ${environment}/main.tf, ex. '${module.vpc.id}'"
}
variable "cidrs" {
  description = "Use these CIDRs for subnets"
  type        = "list"
  default     = ["172.31.1.0/24", "172.31.2.0/24"]
}
variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type        = "list"
  default     = ["us-east-1a", "us-east-1c"]
}
variable "environment" {
  default     = "production"
}
variable "public_subnet_ids" {
  description = "Declare in ${environment}/main.tf, ex. '${module.public_subnet.ids}'"
  type        = "list"
}
