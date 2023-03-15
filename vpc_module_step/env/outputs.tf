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