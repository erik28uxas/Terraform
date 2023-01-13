resource "aws_vpc" "main-vpc" {
    cidr_block           = "10.0.0.0/16"
    instance_tenancy     = "default"
    enable_dns_support   = "true"
    enable_dns_hostnames = "true"
    tags = {
      Name = "main-vpc"
    }
}


# ========  Public Subnets  ========
resource "aws_subnet" "public-main-1" {
    vpc_id                  = aws_vpc.main-vpc.id
    cidr_block              = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "us-west-2a"
    tags = {
        Name = "main-public-1"
    }
}

resource "aws_subnet" "public-main-2" {
    vpc_id                  = aws_vpc.main-vpc.id
    cidr_block              = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "us-west-2b"
    tags = {
      Name = "main-public-2"
    }
}


# ========  Internet GW  ========
resource "aws_internet_gateway" "main-igw" {
    vpc_id = aws_vpc.main-vpc.id
    tags = {
      Name = "main-igw"
    }
}


resource "aws_route_table" "main-public-rt" {
    vpc_id = aws_vpc.main-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-igw.id
    }

    tags = {
        Name = "main=public-rt"
    }
}


resource "aws_route_table_association" "main-public-1" {
    subnet_id      = aws_subnet.public-main-1.id
    route_table_id = aws_route_table.main-public-rt.id
}

resource "aws_route_table_association" "main-public-2" {
    subnet_id      = aws_subnet.public-main-2.id
    route_table_id = aws_route_table.main-public-rt.id
}