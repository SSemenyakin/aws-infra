resource "aws_vpc" "infra" {
  cidr_block = "192.168.0.0/16"

  tags {
    Name = "Infra"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = "${aws_vpc.infra.id}"
  cidr_block        = "${var.infra_subnets["public"]}"
  availability_zone = "${element(var.AZ, 0)}"

  tags {
    Name = "infra_public"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = "${aws_vpc.infra.id}"
  cidr_block        = "${var.infra_subnets["private"]}"
  availability_zone = "${element(var.AZ, 0)}"

  tags {
    Name = "infra_private"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.infra.id}"

  tags {
    Name = "infra_igw"
  }
}

resource "aws_route_table" "infra" {
  vpc_id = "${aws_vpc.infra.id}"

  tags {
    Name = "infra_route_table"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}

resource "aws_route_table_association" "infra_public_subnet" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.infra.id}"
}
