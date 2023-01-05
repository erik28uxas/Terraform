output "instnace" {
    value = aws_instance.main-ec2.public_ip  
}

output "rds" {
    value = aws_db_instance.mariadb.endpoint  
}