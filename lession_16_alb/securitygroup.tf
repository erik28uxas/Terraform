resource "aws_security_group" "instance" {
    name = "security-group-for-instance"
    vpc_id = aws_vpc.main-vpc.id

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        security_groups = [aws_security_group.alb.id]
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
}

