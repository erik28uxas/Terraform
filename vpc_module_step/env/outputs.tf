output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_cidr
}

output "igw_id" {
   description = "The ID of the Internet Gateway"
   value       =  module.vpc.igw_id
}

output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = module.vpc.public_route_table_ids
}