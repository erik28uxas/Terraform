# output "vpc_id" {
#   description = "The ID of the VPC"
#   value       = aws_vpc.main_vpc.id
# }

# output "vpc_cidr" {
#   description = "The ID of the VPC"
#   value       = aws_vpc.main_vpc.cidr_block
# }

# output "private_subnets" {
#   description = "List of IDs of private subnets"
#   value       = aws_subnet.private_subnets[*].id
# }

# output "private_subnets_cidr_blocks" {
#   description = "List of cidr_blocks of private subnets"
#   value       = compact(aws_subnet.private_subnets[*].cidr_block)
# }

# output "public_subnets" {
#   description = "List of IDs of public subnets"
#   value       = aws_subnet.public_subnets[*].id
# }

# output "public_subnets_cidr_blocks" {
#   description = "List of cidr_blocks of public subnets"
#   value       = compact(aws_subnet.public_subnets[*].cidr_block)
# }

# output "public_route_table_ids" {
#   description = "List of IDs of public route tables"
#   value       = aws_route_table.public_subnets[*].id
# }

# output "private_route_table_ids" {
#   description = "List of IDs of private route tables"
#   value       = aws_route_table.private_subnets[*].id
# }

# output "public_internet_gateway_route_id" {
#   description = "ID of the internet gateway route"
#   value       = try(aws_route.public_internet_gateway[0].id, "")
# }

# output "private_nat_gateway_route_ids" {
#   description = "List of IDs of the private nat gateway route"
#   value       = aws_route.private_nat_gateway[*].id
# }

# output "private_route_table_association_ids" {
#   description = "List of IDs of the private route table association"
#   value       = aws_route_table_association.private[*].id
# }

# output "public_route_table_association_ids" {
#   description = "List of IDs of the public route table association"
#   value       = aws_route_table_association.public[*].id
# }

# output "nat_ids" {
#   description = "List of allocation ID of Elastic IPs created for AWS NAT Gateway"
#   value       = aws_eip.nat[*].id
# }

# output "nat_public_ips" {
#   description = "List of public Elastic IPs created for AWS NAT Gateway"
#   value       = var.reuse_nat_ips ? var.external_nat_ips : aws_eip.nat[*].public_ip
# }

# output "natgw_ids" {
#   description = "List of NAT Gateway IDs"
#   value       = aws_nat_gateway.main[*].id
# }

# output "igw_id" {
#   description = "The ID of the Internet Gateway"
#   value       = aws_internet_gateway.vpc_gw.id
# }

# output "azs" {
#   description = "A list of availability zones specified as argument to this module"
#   value       = var.azs
# }

# output "name" {
#   description = "The name of the VPC specified as argument to this module"
#   value       = var.name
# }