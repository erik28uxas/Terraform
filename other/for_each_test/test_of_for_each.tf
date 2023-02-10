resource "aws_security_group" "dynimic" {
    name        = "${var.env}-sg"
    description = "Sg for ${var.env} with ingress prots ${(var.env == "dev" ? var.custom_tags["dev"] : var.custom_tags["prod"])}"
    
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
      Name = "Sg for ${var.env}"
    }
}

# ===== Vars =====

variable "env" {
    default = "prod"
}

variable "ip_ranges" {
    default = {
        "prod" = ["80", "443"]
        "dev"  = ["80", "22"]
    }  
}

variable "custom_tags" {
    description = "Custom, Dynomic tags for SG"
    type        = map(string)
    default     = {
        "prod" = "80, 443",
        "dev"  = "80, 22"
    }
}