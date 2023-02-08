resource "aws_lb" "example" {
    name               = var.cluster_name
    load_balancer_type = "application"
    # subnets            = data.aws_subnets.default.id
    subnets            = ["us-west-2a", "us-west-2b", "us-west-2c"]
    security_groups    = [aws_security_group.alb.id] 
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.example.arn
    port              = local.http_port
    protocol          = "HTTP"

    default_action {
        type = "fixed-response"

        fixed_response {
            content_type = "text/plain"
            message_body = "404: page not found"
            status_code  = 404
        }
    }
}

resource "aws_lb_target_group" "asg" {
    name     = var.cluster_name
    port     = var.server_port
    protocol = "HTTP"
    vpc_id   = data.aws_vpc.default.id

    health_check {
      path                = "/"
      protocol            = "HTTP"
      matcher             = "200"
      interval            = 30
      timeout             = 3
      healthy_threshold   = 2
      unhealthy_threshold = 2
    }  
}

resource "aws_lb_listener_rule" "asg" {
    listener_arn = aws_lb_listener.http.arn
    priority     = 100

    condition {
      path_pattern {
        values = ["*"]
      }
    }

    action {
      type = "forward"
      target_group_arn = aws_lb_target_group.asg.arn
    }
}