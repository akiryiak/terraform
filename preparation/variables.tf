variable "region" {
  default     = "us-west-2"
}
variable "access_key" {
  description = "AWS access key, do not store in VCS"
}
variable "secret_key" {
  description = "AWS secret key, do not store in VCS"
}
variable "bucket_name" {
  default     = "ato-terraform-state"
}
variable "versioning" {
  default     = "false"
}
