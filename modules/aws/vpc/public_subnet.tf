# Public Subnets
resource "aws_internet_gateway" "public" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name        = "${var.project}-igw"
    terraform   = "true"
    environment = "${var.environment}"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${element(var.public_cidrs, count.index)}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.azs)}"

  tags {
    Name        = "${var.project}-public_subnet-${element(var.azs, count.index)}"
    terraform   = "true"
    environment = "${var.environment}"
  }

  lifecycle {
    create_before_destroy = true
  }

  map_public_ip_on_launch = true
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.public.id}"
  }

  tags {
    Name        = "${var.project}-public_route_table"
    terraform   = "true"
    environment = "${var.environment}"
  }
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.azs)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}
