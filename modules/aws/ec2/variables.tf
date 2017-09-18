variable "ec2_ami" {
  default = "ami-6df1e514"
}
variable "ec2_type" {
  default = "t2.micro"
}
variable "ec2_name" {
  default = ""
}
variable "sg_id" {
  default = ""
}
variable "subnet_id" {
  default = ""
}
variable "ssh_key" {
  default = ""
}
variable "public_ip" {
  default = true
}
variable "environment" {
  default = "production"
}
