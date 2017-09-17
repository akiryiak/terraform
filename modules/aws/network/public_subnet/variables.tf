variable "name" {
  default     = "public"
}
variable "vpc_id" {
  description = "Declare in ${environment}/main.tf, ex. '${module.vpc.id}'"
}
variable "cidrs" {
  description = "Use these CIDRs for subnets"
  type        = "list"
  default     = ["172.31.3.0/24", "172.31.4.0/24"]
}
variable "azs" {
  description = "Run the EC2 Instances in these Availability Zones"
  type        = "list"
  default     = ["us-west-2a", "us-west-2c"]
}
variable "environment" {
  default     = "production"
}
