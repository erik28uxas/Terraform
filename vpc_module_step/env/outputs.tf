output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.aws_vpc.main_vpc.id
}

output "vpc_cidr" {
  description = "The ID of the VPC"
  value       = module.aws_vpc.main_vpc.cidr_block
}
