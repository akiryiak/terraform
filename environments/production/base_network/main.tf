provider "aws" {
  region           = "${var.region}"
  access_key       = "${var.access_key}"
  secret_key       = "${var.secret_key}"
}

data "terraform_remote_state" "network" {
  backend          = "s3"
  config {
    bucket         = "${var.s3_state_bucket}"
    key            = "${var.s3_state_key}"
    region         = "${var.region}"
    access_key     = "${var.access_key}"
    secret_key     = "${var.secret_key}"
  }
}

module "vpc" {
  source           = "../../../modules/aws/network/vpc"
}

module "public_subnet" {
  source           = "../../../modules/aws/network/public_subnet"
  vpc_id           = "${module.vpc.id}"
  cidrs            = "${var.public_cidrs}"
  azs              = "${var.azs}"
}

module "private_subnet" {
  source            = "../../../modules/aws/network/private_subnet"
  vpc_id            = "${module.vpc.id}"
  cidrs             = "${var.private_cidrs}"
  azs               = "${var.azs}"
  public_subnet_ids = "${module.public_subnet.ids}"
}

module "bastion" {
  source            = "../../../modules/aws/network/bastion"
  vpc_id            = "${module.vpc.id}"
  vpc_cidr          = "${module.vpc.cidr}"
  public_subnet_ids = "${module.public_subnet.ids}"
  azs               = "${var.azs}"
  key_name          = "${var.ssh_key}"
}
