data "template_file" "user_data_registry" {
  template = "${file("${path.module}/user_data.sh")}"
}

#TODO: list should be inside of sg_id variable
resource "aws_instance" "registry_instance" {
  ami                          = "${var.ec2_ami}"
  instance_type                = "${var.ec2_type}"
  vpc_security_group_ids       = ["${var.sg_id}"]
  subnet_id                    =  "${var.subnet_id}"
  key_name                     = "${var.ssh_key}"
  user_data                    = "${data.template_file.user_data_registry.rendered}"
  associate_public_ip_address  = "${var.public_ip}"
  tags {
    Name                       = "${var.ec2_name}"
    terraform                  = "true"
    environment                = "${var.environment}"
  }
}
