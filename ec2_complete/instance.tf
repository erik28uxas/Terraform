resource "aws_instance" "name" {
    ami                    = var.AMIS[var.AWS_REGION]
    instance_type          = "t2.micro"
    vpc_security_group_ids = ""
    subnet_id              = ""
    key_name               = aws_key_pair.name.key_name

    root_block_device {
      volume_size           = 8
      volume_type           = "gp2"
      delete_on_termination = false
    }
    
    
    
    tags = {
      "Name" = name
    }
}