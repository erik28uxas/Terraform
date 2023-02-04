resource "aws_security_group" "instance" {
    name = "${var.cluster_name}-instance"

    egress {
        from_port   = var.server_port 
        to_port     = var.server_port
        protocol    = local.tcp_protoxol
        cidr_blocks = local.all_ips
    }
    
    ingress {
        from_port       = var.server_port
        to_port         = var.server_port
        protocol        = local.tcp_protoxol
        security_groups = [aws_security_group.alb.id]
    }

    ingress {
        from_port   = local.ssh_port
        to_port     = local.ssh_port
        protocol    = local.tcp_protoxol
        cidr_blocks = local.all_ips
    }

    tags = {
      Name = "instance-in-asg-sg-group"
    }   
}


resource "aws_security_group" "alb" {
    name = "${var.cluster_name}-alb"
    
    tags = {
        Name = "alb-security-group"
    } 
}

resource "aws_security_group_rule" "alb-inbound-traffic" {
    type              = "ingress"
    security_group_id = aws_security_group.alb.id

    from_port   = local.http_port
    to_port     = local.http_port
    protocol    = local.tcp_protoxol
    cidr_blocks = local.all_ips 
}

resource "aws_security_group_rule" "alb-outbound-traffic" {
    type              = "egress"
    security_group_id = aws_security_group.alb.id

    from_port   = local.any_port
    to_port     = local.any_port
    protocol    = local.any_protocol
    cidr_blocks = local.all_ips
}