terraform {
  backend "s3" {
    bucket = "atos-terraform"
    key    = "vpc/terraform.state"
    region = "eu-west-1"
  }
}
