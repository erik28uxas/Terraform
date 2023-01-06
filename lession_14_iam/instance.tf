resource "aws_instance" "main-ec2" {
    ami                    = var.AMIS[var.AWS_REGION]
    instance_type          = "t2.micro"
    subnet_id              = aws_subnet.public-main-1.id
    vpc_security_group_ids = [aws_security_group.main-ec2-sg.id]
    key_name               = aws_key_pair.id_rsa.key_name
    iam_instance_profile   = aws_iam_instance_profile.s3-mybucket-role-instanceprofile.name
}