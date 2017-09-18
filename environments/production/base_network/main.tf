provider "aws" {
  region           = "${var.region}"
  access_key       = "${var.access_key}"
  secret_key       = "${var.secret_key}"
}

terraform {
  backend "s3" {
    key            = "base_network/terraform.tfstate"
    region         = "us-west-2"
  }
}

module "vpc" {
  source           = "git@github.com:akiryiak/terraform.git//modules/aws/network/vpc"
}

module "public_subnet" {
  source           = "git@github.com:akiryiak/terraform.git//modules/aws/network/public_subnet"
  vpc_id           = "${module.vpc.id}"
  cidrs            = "${var.public_cidrs}"
  azs              = "${var.azs}"
}

module "private_subnet" {
  source            = "git@github.com:akiryiak/terraform.git//modules/aws/network/private_subnet"
  vpc_id            = "${module.vpc.id}"
  cidrs             = "${var.private_cidrs}"
  azs               = "${var.azs}"
  public_subnet_ids = "${module.public_subnet.ids}"
}

module "bastion" {
  source            = "git@github.com:akiryiak/terraform.git//modules/aws/network/bastion"
  vpc_id            = "${module.vpc.id}"
  vpc_cidr          = "${module.vpc.cidr}"
  public_subnet_ids = "${module.public_subnet.ids}"
  azs               = "${var.azs}"
  key_name          = "${var.ssh_key}"
}
