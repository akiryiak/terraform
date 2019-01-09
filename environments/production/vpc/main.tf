module "vpc" {
  source = "../../../modules/aws/network/vpc"
  bastion_ssh_public_key = "${var.bastion_ssh_public_key}"
}

