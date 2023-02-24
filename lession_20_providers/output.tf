# output "region_1" {
#     value       = data.aws_region.region_1.name
#     description = "The name of 1st region"
# }

# output "region_2" {
#     value       = data.aws_region.region_2.name
#     description = "The name of 2nd region"
# }




output "instance_region_1" {
    value = aws_instance.region_1.availability_zone
}

output "instance_region_2" {
    value = aws_instance.region_2.availability_zone
}