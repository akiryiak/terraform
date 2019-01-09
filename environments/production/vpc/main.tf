module "vpc" {
  source                 = "../../../modules/aws/vpc"
  bastion_ssh_public_key = "${var.bastion_ssh_public_key}"
  azs                    = ["eu-west-1a"]
}
