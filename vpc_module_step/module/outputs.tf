output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main_vpc.id
}

output "vpc_cidr" {
  description = "The ID of the VPC"
  value       = aws_vpc.main_vpc.cidr_block
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
#   value       = try(aws_internet_gateway.vpc_gw[0].id, "")
  value       = aws_internet_gateway.vpc_gw.id
}

output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = aws_route_table.public[*].id
}
