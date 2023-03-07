data "aws_availability_zones" "available" {}

resource "aws_vpc" "main_vpc" {
    cidr_block           = var.vpc_cidr
    instance_tenancy     = "default"
    enable_dns_support   = "true"
    enable_dns_hostnames = "true"

    tags = {
        Name  = "Main-VPC"
    }
}

resource "aws_internet_gateway" "vpc_gw" {
    vpc_id = aws_vpc.main_vpc.id
    
    tags = {
      Name = "Main-VPC-IG"
    }

}

resource "aws_subnet" "public_subnets" {
    count                   = length(var.public_subnet_cidrs)
    vpc_id                  = aws_vpc.main_vpc.id
    cidr_block              = element(var.public_subnet_cidrs, count.index)
    availability_zone       = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = "true"

    tags = {
        Name = "Main-Piblic-${count.index + 1}"
    }
}
resource "aws_route_table" "public_subnets" {
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.vpc_gw.id
    }

    tags = {
      Name = "Main-VPC"
    }
}

resource "aws_route_table_association" "public_routes" {
    count          = length(aws_subnet.public_subnets[*].id)
    route_table_id = aws_route_table.public_subnets.id
    subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}
