# Private Subnets
resource "aws_eip" "nat" {
  vpc = true

  count = "${length(var.azs)}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

  count = "${length(var.azs)}"

  tags {
    Name        = "${var.project}-nat_gw-${element(var.azs, count.index)}"
    terraform   = "true"
    environment = "${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(var.private_cidrs, count.index)}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.azs)}"

  tags {
    Name        = "${var.project}-private_subnet-${element(var.azs, count.index)}"
    terraform   = "true"
    environment = "${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  count  = "${length(var.azs)}"

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.nat.*.id, count.index)}"
  }

  tags {
    Name        = "${var.project}-private_route_table-${element(var.azs, count.index)}"
    terraform   = "true"
    environment = "${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "private" {
  count          = "${length(var.azs)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"

  lifecycle {
    create_before_destroy = true
  }
}
