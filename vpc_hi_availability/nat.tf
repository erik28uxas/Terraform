resource "aws_eip" "nat-1" {
    vpc = true
}

resource "aws_eip" "nat-2" {
    vpc = true
}

resource "aws_eip" "nat-3" {
    vpc = true
}


resource "aws_nat_gateway" "nat-gw-1" {
    allocation_id = aws_eip.nat-1.id
    subnet_id     = aws_subnet.main-public-1.id
    depends_on    = [aws_internet_gateway.main_gw]
}

resource "aws_nat_gateway" "nat-gw-2" {
    allocation_id = aws_eip.nat-2.id
    subnet_id     = aws_subnet.main-public-2.id
    depends_on    = [aws_internet_gateway.main_gw]
}

resource "aws_nat_gateway" "nat-gw-3" {
    allocation_id = aws_eip.nat-3.id
    subnet_id     = aws_subnet.main-public-3.id
    depends_on    = [aws_internet_gateway.main_gw]
}



# ========  VPC Setup for NAT  ========
resource "aws_route_table" "main-private-1" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gw.id
    }

    tags = {
        Name = "main-private-1"
    }
}

resource "aws_route_table" "main-private-2" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gw-2.id
    }

    tags = {
        Name = "main-private-2"
    }
}

resource "aws_route_table" "main-private-3" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat-gw-3.id
    }

    tags = {
        Name = "main-private-3"
    }
}


# ========  Route Asociations for Ptivate Subnets  ========
resource "aws_route_table_association" "main-private-1-a" {
    subnet_id = aws_subnet.main-private-1.id
    route_table_id = aws_route_table.main-private-1.id
}

resource "aws_route_table_association" "main-private-2-b" {
    subnet_id = aws_subnet.main-private-2.id
    route_table_id = aws_route_table.main-private-2.id
}

resource "aws_route_table_association" "main-private-3-c" {
    subnet_id = aws_subnet.main-private-3.id
    route_table_id = aws_route_table.main-private-3.id
}