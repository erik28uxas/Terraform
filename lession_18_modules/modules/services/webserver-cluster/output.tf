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