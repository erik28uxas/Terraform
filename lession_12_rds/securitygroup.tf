resource "aws_security_group" "main-ec2-sg" {
    vpc_id      = aws_vpc.main.id
    name        = "allow-ssh"
    description = "sg-for-ssh"  

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

    tags = {
      Name = "main-ec2-allow-ssh"
    }
}

resource "aws_security_group" "allow-mariadb" {
    vpc_id      = aws_vpc.main.id
    name        = "allow-mariadb"
    description = "allows to connect main-ec2 to maridadb"
    
    ingress {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        security_groups = [aws_security_group.main-ec2-sg.id]
    }
    
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        self        = true
    }

    tags = {
        Name = "allow-mariadb"
    }
}
    