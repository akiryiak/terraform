resource "aws_internet_gateway" "public" {
  vpc_id                  = "${var.vpc_id}"

  tags {
    Name                  = "${var.name}"
    terraform             = "true"
    environment           = "${var.environment}"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${element(var.cidrs, count.index)}"
  availability_zone       = "${element(var.azs, count.index)}"
  count                   = "${length(var.cidrs)}"

  tags      {
    Name = "${var.name}.${element(var.azs, count.index)}"
    terraform             = "true"
    environment           = "${var.environment}"
  }
  lifecycle {
    create_before_destroy = true
  }

  map_public_ip_on_launch = true
}

resource "aws_route_table" "public" {
  vpc_id                  = "${var.vpc_id}"

  route {
      cidr_block          = "0.0.0.0/0"
      gateway_id          = "${aws_internet_gateway.public.id}"
  }

  tags {
    Name                  = "${var.name}.${element(var.azs, count.index)}"
    terraform             = "true"
    environment           = "${var.environment}"
  }
}

resource "aws_route_table_association" "public" {
  count                   = "${length(var.cidrs)}"
  subnet_id               = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id          = "${aws_route_table.public.id}"
}

#Test ref functionality
resource "aws_instance" "sunet-test" {
  ami           = "ami-6df1e514"
  instance_type = "t2.micro"

  tags {
    Name = "subnet-test"
  }
}
