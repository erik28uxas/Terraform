resource "aws_instance" "example" {
    ami                    = var.AMIS[var.AWS_REGION]
    instance_type          = "t2.micro"
    subnet_id              = aws_subnet.main-public-1.id
    vpc_security_group_ids = [aws_security_group.allow-ssh.id]
    key_name               = aws_key_pair.id_rsa.key_name
    
    tags = {
        "Name" = "First-EC2"
    }
}

resource "aws_ebs_volume" "ebs-vol-1" {
    availability_zone = "us-west-2a"
    size              = 20
    type              = "gp2"
    tags = {
      "Name" = "First-EC2-EBS-vol-1"
    }
}

resource "aws_volume_attachment" "ebs-vol-1-attachment" {
    device_name = "/dev/xvdh"
    volume_id = aws_ebs_volume.ebs-vol-1.id
    instance_id = aws_instance.example.id
    stop_instance_before_detaching = true  
}