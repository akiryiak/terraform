output "id"   { value = "${aws_vpc.vpc.id}" }
output "vpc_cidr" { value = "${aws_vpc.vpc.cidr_block}" }
output "aws_subnet_public_ids" { value = ["${aws_subnet.public.*.id}"] }
output "aws_subnet_private_ids" { value = ["${aws_subnet.private.*.id}"] }
output "bastion_private_ip" { value = "${aws_instance.bastion.*.private_ip}" }
output "bastion_public_ip"  { value = "${aws_instance.bastion.*.public_ip}" }
