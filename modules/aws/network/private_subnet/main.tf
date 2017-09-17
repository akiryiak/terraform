resource "aws_eip" "nat" {
  vpc                     = true

  count                   = "${length(var.azs)}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id           = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id               = "${element(var.public_subnet_ids, count.index)}"

  count                   = "${length(var.azs)}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${element(var.cidrs, count.index)}"
  availability_zone       = "${element(var.azs, count.index)}"
  count                   = "${length(var.cidrs)}"

  tags      {
    Name                  = "${var.name}.${element(var.azs, count.index)}"
    terraform             = "true"
    environment           = "${var.environment}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table" "private" {
  vpc_id                  = "${var.vpc_id}"
  count                   = "${length(var.cidrs)}"

  route {
    cidr_block            = "0.0.0.0/0"
    nat_gateway_id        = "${element(aws_nat_gateway.nat.*.id, count.index)}"
  }

  tags      {
    Name                  = "${var.name}.${element(var.azs, count.index)}"
    terraform             = "true"
    environment           = "${var.environment}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route_table_association" "private" {
  count                   = "${length(var.cidrs)}"
  subnet_id               = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id          = "${element(aws_route_table.private.*.id, count.index)}"

  lifecycle {
    create_before_destroy = true
  }
}
