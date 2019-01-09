variable "region" {
  default = "eu-west-1"
}

variable "aws_access_key" {
  description = "AWS access key, do not store in VCS"
}

variable "aws_secret_key" {
  description = "AWS secret key, do not store in VCS"
}

variable "bastion_ssh_public_key" {
  description = "Mandatory variable, public ssh key for bastion login"
}
