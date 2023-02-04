output "alb_dns_name" {
    value = aws_lb.example.dns_name
    description = "The domain name of the load balancer"
}

output "asg_name" {
    value = aws_autoscaling_group.example.name
    description = "The name of Auto Scaling Group"
}

output "alb_security_gorup" {
    value = aws_security_group.alb.id
    description = "The Id of ALB SG "
}

# output "address" {
#     value       = aws_db_instance.example.address
#     description = "Connect to the database at this endpoint"
# }
#   output "port" {
#     value       = aws_db_instance.example.port
#     description = "The port the database is listening on"
# }