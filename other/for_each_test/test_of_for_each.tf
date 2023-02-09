resource "aws_security_group" "allow_ssh" {
    name        = "${var.env}-ssg"
    description = "SG that allows ssh and all egress traffic"
    
    dynamic "ingress" {
        for_each = lookup(var.ip_ranges, var.env)
        content {
            from_port   = ingress.value
            to_port     = ingress.value
            protocol    = "tcp"
            cidr_blocks = ["172.117.124.247/32"]
        }
    }
    
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

# ===== Vars =====

variable "env" {
    default = "dev"
}

variable "ip_ranges" {
    default = {
        "prod" = ["80", "443"]
        "dev"  = ["80", "22"]
    }  
}