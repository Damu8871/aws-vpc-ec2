resource "aws_vpc" "main" {
  cidr_block                       = "${var.cidr_block}"
  instance_tenancy                 = "${var.tenancy}"
  enable_dns_support               = "${var.enable_dns_support}"
  enable_dns_hostnames             = "${var.enable_dns_hostnames}"
  enable_classiclink               = "${var.enable_classiclink}"
  assign_generated_ipv6_cidr_block = "${var.assign_generated_ipv6_cidr_block}"
 
  tags {
    ManagedBy = "Terraform"
  }
}


resource "aws_subnet" "main" {
  vpc_id                           = "${aws_vpc.main.id}"
  cidr_block                       = "${var.subnet_cidr}"
  availability_zone                = "${var.availability_zone}"
  map_public_ip_on_launch          = "${var.map_public_ip_on_launch}"
  assign_ipv6_address_on_creation  = "${var.assign_ipv6_address_on_creation}"
  
  tags {
    ManagedBy = "Terraform"
  }
}


resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"
}


resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }
}


resource "aws_route_table_association" "main" {
  subnet_id      = "${aws_subnet.main.id}"
  route_table_id = "${aws_route_table.main.id}"
}







