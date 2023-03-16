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
  count = length(var.public_subnet_cidrs) > 0 ? 1 : 0

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

  route_table_id         = aws_route_table.public_subnets[0].id
  destination_cidr_block = var.default_cidr
  gateway_id             = aws_internet_gateway.vpc_gw[0].id
}

# ========  Public Subnets  ========
resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = element(concat(var.public_subnet_cidrs, [""]), count.index)
  availability_zone       = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) > 0 ? element(var.azs, count.index) : null
  availability_zone_id    = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    {
      Name = try(
        var.public_subnet_names[count.index],
        format("${var.name}-${var.public_subnet_suffix}-%s", element(var.azs, count.index))
      )
    },
    var.tags,
    var.public_subnet_tags,
    lookup(var.public_subnet_tags_per_az, element(var.azs, count.index), {})
  )
}


resource "aws_route_table_association" "public" {
  count     = length(var.public_subnet_cidrs)

  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_subnets[0].id
}