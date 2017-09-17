resource "aws_security_group" "bastion" {
  name                        = "${var.name}"
  vpc_id                      = "${var.vpc_id}"
  description                 = "Bastion security group"

  tags      {
    Name                      = "${var.name}"
    terraform                 = "true"
    environment               = "${var.environment}"
  }
  lifecycle {
    create_before_destroy     = true
  }

  ingress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["${var.ssh_cidrs}"]
  }

  egress {
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion" {
  #should be changed to custom security ami
  ami                         = "${var.ami}"
  instance_type               = "${var.instance_type}"
  subnet_id                   = "${element(var.public_subnet_ids, count.index)}"
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${aws_security_group.bastion.id}"]
  associate_public_ip_address = true
  count                       = "${length(var.azs)}"

  tags      {
    Name                      = "${var.name}.${element(var.azs, count.index)}"
    terraform                 = "true"
    environment               = "${var.environment}"
  }
  lifecycle {
    create_before_destroy     = true
  }
}
