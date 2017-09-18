resource "aws_vpc" "vpc" {
  cidr_block            = "${var.cidr_block}"
  enable_dns_hostnames  = "${var.vpc_enable_dns_hostnames}"
  enable_dns_support    = "${var.vpc_enable_dns_support}"

  tags = {
    Name                = "${var.vpc_name}"
    terraform           = "true"
    environment         = "${var.vpc_environment}"
  }
}
#Test ref functionality
