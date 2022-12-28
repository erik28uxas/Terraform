resource "aws_vpc" "main" {
    cidr_block           = "10.0.0.0/16"
    instance_tenancy     = "default"
    enable_dns_support   = "true"
    enable_dns_hostnames = "true"
    tags = {
      "Name" = "main"
    }
}


# ========  Public Subnets  ========
resource "aws_subnet" "main-public-1" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.1.0/24"
    map_public_ip_on_launch = "true"
    avavailability_zone     = "us-west-2a" 
    tags = {
        Name = "main-public-1"
    }
}

resource "aws_subnet" "main-public-2" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.2.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "us-west-2b"
    tags = {
        Name = "main-public-2"
    }
}

resource "aws_subnet" "main-public-3" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.3.0/24"
    map_public_ip_on_launch = "true"
    availability_zone       = "us-west-2b"
    tags = {
        Name = "main-public-3"
    }
}


# ========  Internet GW  ========
resource "aws_internet_gateway" "main_gw" {
    vpc_id = aws_vpc.main.id
    
    tags = {
        Name = "main"
    }  
}


# ========  Route Table  ========
resource "aws_route_table" "main-public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main_gw.id
    }
  
    tags = {
        Name = "main"
    }
}

# ========  RT Association to Public Subnet  ========
resource "aws_route_table_association" "main-public-1" {
    subnet_id      = aws_subnet.main-public-1.id
    route_table_id = aws_route_table.main-public.id  
}

resource "aws_route_table_association" "main-public-2" {
    subnet_id      = aws_subnet.main-public-2.id
    route_table_id = aws_route_table.main-public.id
}

resource "aws_route_table_association" "main-private-3" {
    subnet_id      = aws_subnet.main-public-3.id
    route_table_id = aws_route_table.main-public.id
  
}