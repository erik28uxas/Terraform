output "aws_public_subnets" {
    value = aws_subnet.public_subnets[*].id
}