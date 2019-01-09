data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}
resource "aws_key_pair" "bastion" {
  key_name   = "${var.project}-bastion"
  public_key = "${var.bastion_ssh_public_key}"
}
resource "aws_security_group" "bastion" {
  name                        = "${var.project}-bastion-sg"
  vpc_id                      = "${aws_vpc.vpc.id}"
  description                 = "Bastion security group"
  count                       = "${var.bastion_host}"

  tags      {
    Name                      = "${var.project}-bastion-sg"
    terraform                 = "true"
    environment               = "${var.environment}"
  }
  lifecycle {
    create_before_destroy     = true
  }
}
resource "aws_security_group_rule" "allow_vpc_traffic" {
    description = "Allow all traffic inside VPC"
    count       = "${var.bastion_host}"
    type        = "ingress"
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["${aws_vpc.vpc.cidr_block}"]
    security_group_id = "${aws_security_group.bastion.id}" 
}
resource "aws_security_group_rule" "allow_all_egress" {
    description = "Allow all outgoing traffic"
    count       = "${var.bastion_host}"
    type        = "egress"
    protocol    = -1
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${aws_security_group.bastion.id}" 
}
resource "aws_security_group_rule" "allow_ssh" {
    description = "Allow ssh traffic"
    count       = "${var.bastion_host}"
    type        = "ingress"
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["${var.bastion_ssh_access_cidr}"]
    security_group_id = "${aws_security_group.bastion.id}" 
}
resource "aws_instance" "bastion" {
  #should be changed to custom secure ami
  ami                         = "${var.bastion_ami ? var.bastion_ami : data.aws_ami.amazon_linux.id}"
  instance_type               = "${var.bastion_instance_type}"
  subnet_id                   = "${element(aws_subnet.public.*.id, count.index)}"
  key_name                    = "${var.project}-bastion"
  vpc_security_group_ids      = ["${aws_security_group.bastion.id}"]
  associate_public_ip_address = true
  count                       = "${var.bastion_host ? length(var.azs) : 0}"

  tags      {
    Name                      = "${var.project}-bastion-ec2-${element(var.azs, count.index)}"
    terraform                 = "true"
    environment               = "${var.environment}"
  }
  lifecycle {
    create_before_destroy     = true
  }

  depends_on = ["aws_key_pair.bastion"]
}