# ========  DATAs  ========
data "aws_availability_zones" "available" {}


# ========  VPC  ========
resource "aws_vpc" "main_vpc" {
    cidr_block           = var.vpc_cidr
    instance_tenancy     = "default"
    enable_dns_support   = "true"
    enable_dns_hostnames = "true"

    tags = {
        Name  = "Main-VPC"
    }
}


# ========  Internet GW  ========
resource "aws_internet_gateway" "vpc_gw" {
    vpc_id = aws_vpc.main_vpc.id
    
    tags = {
        Name = "Main-VPC-IG"
    }
}


# ========  Public Subnets  ========
resource "aws_subnet" "public_subnets" {
    count                   = length(var.public_subnet_cidrs)
    vpc_id                  = aws_vpc.main_vpc.id
    cidr_block              = element(var.public_subnet_cidrs, count.index)
    availability_zone       = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "Main-Piblic-${count.index + 1}"
    }
}


# ========  Route Table for Public Subnets  ========
resource "aws_route_table" "public_subnets" {
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block = var.default_cidr
        gateway_id = aws_internet_gateway.vpc_gw.id
    }

    tags = {
        Name = "Main-VPC"
    }
}


# ========  Route Table Asociations for Public Subnets  ========
resource "aws_route_table_association" "public_routes" {
    count          = length(aws_subnet.public_subnets[*].id)
    route_table_id = aws_route_table.public_subnets.id
    subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
}


# ========  Private Subnets  ========
resource "aws_subnet" "private_subnets" {
    count                   = length(var.private_subnet_cidrs)
    vpc_id                  = aws_vpc.main_vpc.id
    cidr_block              = element(var.private_subnet_cidrs, count.index)
    availability_zone       = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = false

    tags = {
        Name = "Main-Private-${count.index + 1}"
    }
}


# ========  EIPs for NAT  ========
resource "aws_eip" "nat" {
    count = length(var.private_subnet_cidrs)
    vpc   = true

    tags = {
        Name = "EIP-for-Main-VPC-${count.index + 1} "
    }
}


# ========  NAT Gateways  ========
resource "aws_nat_gateway" "nat_gw" {
    count         = length(var.private_subnet_cidrs)
    allocation_id = element(aws_eip.nat.*.id, count.index)
    subnet_id     = element(aws_subnet.public_subnets.*.id, count.index)
    depends_on    = [aws_internet_gateway.vpc_gw]
}


# ========  NAT Route Tables  ========
resource "aws_route_table" "private_subnets" {
    vpc_id = aws_vpc.main_vpc.id
    route {
        cidr_block     = var.default_cidr
        nat_gateway_id = aws_nat_gateway.nat_gw.*.id
    }
    # tags = {
    #     Name = "Main-Private-NAT-${count.index + 1}"
    # }
}


# ========  NAT Route Asociations for Ptivate Subnets  ========
resource "aws_route_table_association" "private_rouutes" {
    count          = length(aws_subnet.private_subnets[*].id)
    route_table_id = aws_route_table.private_subnets.id
    subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)  
}

