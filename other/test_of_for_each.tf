resource "aws_security_group" "allow_ssh" {
    name        = "Dynamic SSH"
    description = "SG that allows ssh and all egress traffic"
    
    dynamic "ingress" {
        for_each = [ "22", "80", "443", "8080", "3350" ]
        content {
            from_port   = ingress.value
            to_port     = ingress.value
            protocol    = "tcp"
            cidr_blocks = ["172.117.124.247/32"]
        }
    }

    # ingress {
    #     from_port   = 22
    #     to_port     = 22
    #     protocol    = "tcp"
    #     cidr_blocks = ["172.117.124.247/32"]
    # }

    # ingress {
    #     from_port   = 22
    #     to_port     = 22
    #     protocol    = "tcp"
    #     cidr_blocks = ["108.214.21.213/32"]
    # }

    # ingress {
    #     from_port   = 22
    #     to_port     = 22
    #     protocol    = "tcp"
    #     cidr_blocks = ["155.186.125.162/32"]
    # }
    
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "allow-ssh"
    }
}