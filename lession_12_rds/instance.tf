resource "aws_instance" "main-ec2" {
    ami                    = var.AMIS[var.AWS_REGION]
    instance_type          = "t2.micro"
    subnet_id              = aws_subnet.main-public-1.id
    vpc_security_group_ids = [aws_security_group.main-ec2-sg.id]
    key_name               = aws_key_pair.id_rsa.key_name
}