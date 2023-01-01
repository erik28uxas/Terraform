resource "aws_security_group" "allow-ssh" {
    vpc_id      = aws_vpc.main.id
    name        = "allow-ssh"
    description = "SG that allows ssh and all egress traffic"
    
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["172.117.124.247/32"]
    }

ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["108.214.21.213/32"]
    }

ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["155.186.125.162/32"]
    }

    tags = {
      Name = "allow-ssh"
    }
}