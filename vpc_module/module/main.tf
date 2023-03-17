# locals {
#   max_subnet_length = max(
#     length(var.private_subnet_cidrs),
#     # length(var.database_subnets),
#   )
#   nat_gateway_count = var.single_nat_gateway ? 1 : var.one_nat_gateway_per_az ? length(var.azs) : local.max_subnet_length
# }

# # ========  VPC  ========
# resource "aws_vpc" "main_vpc" {
#   cidr_block            = var.vpc_cidr
#   instance_tenancy      = var.instance_tenancy
#   enable_dns_hostnames  = var.enable_dns_hostnames
#   enable_dns_support    = var.enable_dns_support
    
#   tags = {
#     Name = "M"
#   }
# }


# # ========  Internet GW  ========
# resource "aws_internet_gateway" "vpc_gw" {
#   vpc_id = aws_vpc.main_vpc.id
  
#   tags = {
#     Name = "Main-VPC-IG"
#   }
# }


# ========  Route Table for Public Subnets  ========
# resource "aws_route_table" "public_subnets" {
#   count = length(var.public_subnet_cidrs)

#   vpc_id = aws_vpc.main_vpc.id
    
#   tags = {
#     Name = "Main-Public-RT"
#   }
# }

# resource "aws_route" "public_internet_gateway" {
#   count = length(var.public_subnet_cidrs, count.index)

#   route_table_id         = aws_route_table.public_subnets.id
#   destination_cidr_block = var.default_cidr
#   gateway_id             = aws_internet_gateway.vpc_gw.id
# }

# ========  Route Table for Private Subnets  ========
# resource "aws_route_table" "private" {
#   count = local.max_subnet_length > 0 ? local.nat_gateway_count : 0
  
#   vpc_id = aws_vpc.main_vpc.id

#   tags = {
#     Name = "value"
#   }
  
# }

# ========  Public Subnets  ========
# resource "aws_subnet" "public_subnets" {
#   count = length(var.public_subnet_cidrs)

#   vpc_id                  = aws_vpc.main_vpc.id
#   cidr_block              = element(var.public_subnet_cidrs, count.index)
#   availability_zone       = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
#   availability_zone_id    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
#   map_public_ip_on_launch = var.map_public_ip_on_launch

#   tags = {
#     Name = "thing"
#   }
# }

# ========  Private Subnets  ========
# resource "aws_subnet" "private_subnets" {
#   count = length(var.private_subnet_cidrs)

#   vpc_id               = aws_vpc.main_vpc.id
#   cidr_block           = element(var.private_subnet_cidrs, count.index)
#   availability_zone    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
#   availability_zone_id = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
 
#  tags = {
#     Name = "valu_e"
#   }
# }

# ========  EIPs for NAT  ========
# locals {
#   nat_gateway_ips = var.reuse_nat_ips ? var.external_nat_ip_ids : try(aws_eip.nat[*].id, [])
# }

# resource "aws_eip" "nat" {
#   # count = element(concat(var.public_subnet_cidrs, [""]), count.index)
#   count = var.enable_nat_gateway && false == var.reuse_nat_ips ? local.nat_gateway_count : 0

#   vpc = true

#   tags = {
#     Name = "EIP-for-______-VPC-${count.index + 1}"
#   }
  
# }

# resource "aws_nat_gateway" "main" {
#   count = var.enable_nat_gateway ? local.nat_gateway_count : 0

#   allocation_id = element(local.nat_gateway_ips, var.single_nat_gateway ? 0 : count.index)
#   subnet_id     = element(aws_subnet.public_subnets[*], var.single_nat_gateway ? 0 : count.index)

#   depends_on = [aws_internet_gateway.vpc_gw]

#   tags = {
#     Name = "value"
#   }
# }


# resource "aws_route" "private_nat_gateway" {
#   count = var.enable_nat_gateway ? local.nat_gateway_count : 0

#   route_table_id         = element(aws_route_table.private[*].id, count.index)
#   destination_cidr_block = var.nat_gateway_destination_cidr_block
#   nat_gateway_id         = element(aws_nat_gateway.main[*].d, count.index)  
# }

# resource "aws_route_table_association" "private" {
#   count     = length(var.private_subnet_cidrs)

#   subnet_id      = element(aws_subnet.private_subnets[*].id, count.index) 
#   route_table_id = element(aws_subnet.private_subnets[*].id, var.single_nat_gateway ? 0 : count.index)
# }

# resource "aws_route_table_association" "public" {
#   count     = length(var.public_subnet_cidrs)

#   subnet_id      = element(aws_subnet.public_subnets[0].id, count.index)
#   route_table_id = aws_route_table.public_subnets[0].id
# }