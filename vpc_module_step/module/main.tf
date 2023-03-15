resource "aws_vpc" "main_vpc" {
  cidr_block            = var.vpc_cidr
  instance_tenancy      = var.instance_tenancy
  enable_dns_hostnames  = var.enable_dns_hostnames
  enable_dns_support    = var.enable_dns_support
    
  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.vpc_tags,
  )
}


# ========  Internet GW  ========
resource "aws_internet_gateway" "vpc_gw" {
#   count = local.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0
  
  vpc_id = aws_vpc.main_vpc.id
  
  tags = merge(
    { "Name" = var.name },
    var.tags,
    var.igw_tags,
  )
}


# ========  Route Table for Public Subnets  ========
resource "aws_route_table" "public_subnets" {
#   count = local.create_vpc && length(var.public_subnets) > 0 ? 1 : 0
  count = length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.main_vpc.id
    
  tags = merge(
    { "Name" = "${var.name}-${var.public_subnet_suffix}" },
    var.tags,
    var.public_route_table_tags,
  )
}

resource "aws_route" "public_internet_gateway" {
#   count = local.create_vpc && var.create_igw && length(var.public_subnets) > 0 ? 1 : 0
  count = var.create_igw && length(var.public_subnets) > 0 ? 1 : 0

  route_table_id         = aws_route_table.public_subnets.id
  destination_cidr_block = var.default_cidr
  gateway_id             = aws_internet_gateway.vpc_gw.id
}