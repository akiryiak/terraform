# VPC
resource "aws_vpc" "vpc" {
  cidr_block           = "${var.vpc_cidr_block}"
  enable_dns_hostnames = "${var.vpc_enable_dns_hostnames}"
  enable_dns_support   = "${var.vpc_enable_dns_support}"

  tags = {
    Name        = "${var.project}-vpc"
    terraform   = "true"
    environment = "${var.environment}"
  }
}
