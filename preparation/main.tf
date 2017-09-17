provider "aws" {
  region        = "${var.region}"
  access_key    = "${var.access_key}"
  secret_key    = "${var.secret_key}"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket        = "${var.bucket_name}"
  acl           = "private"

  versioning {
    enabled     = "${var.versioning}"
  }

  tags {
    Name        = "${var.bucket_name}"
    terraform   = "true"
  }
}
