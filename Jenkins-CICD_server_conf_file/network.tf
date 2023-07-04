resource "aws_vpc" "main" {
    cidr_block = var.VPC_cidr
    enable_dns_support = "1"
    enable_dns_hostnames = "1"
    tags = {
        Name = "CoffeeWithDevOps-vpc"
    }
}
resource "aws_subnet" "first" {
    availability_zone = var.Availability_Zone
    cidr_block = var.Subnet_cidr
    map_public_ip_on_launch = "1"
    vpc_id = "${aws_vpc.main.id}"
    tags = {
        Name = "CI/CD-subnet"
    }
}
resource "aws_internet_gateway" "internet" {
    vpc_id = "${aws_vpc.main.id}"
    tags = {
        Name = "CI/CD-IG"
    }
}
resource "aws_route" "internet" {
    route_table_id = "${aws_vpc.main.default_route_table_id}"
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.internet.id}"
}
resource "aws_route_table_association" "a" {
    subnet_id = "${aws_subnet.first.id}"
    route_table_id = "${aws_vpc.main.default_route_table_id}"
}
// create a security group
resource "aws_security_group" "first_sg" {
    vpc_id = "${aws_vpc.main.id}"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }
    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        }
    tags = {
        Name = "CI/CD-sg"
        }
} 