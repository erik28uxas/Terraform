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
