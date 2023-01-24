resource "aws_security_group" "instance" {
    name = "security-group-for-instance"
    vpc_id = aws_vpc.main-vpc.id

    egress {
        from_port   = var.server_port 
        to_port     = var.server_port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port       = var.server_port
        to_port         = var.server_port
        protocol        = "tcp"
        security_groups = [aws_security_group.alb.id]
    }

    ingress {
        from_port   = var.server_port
        to_port     = var.server_port
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

    tags = {
      Name = "instance-in-asg-sg-group"
    }
    
}


resource "aws_security_group" "alb" {
    name = "security-group-for-alb"
    vpc_id = aws_vpc.main-vpc.id

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }  

    tags = {
      Name = "alb-security-group"
    } 
}

