resource "aws_launch_configuration" "example" {
    image_id = var.AMIS[var.AWS_REGION]
    instance_type = "t2.micro"
    security_groups = [aws_security_group.instance.id]  

    user_data = <<-EOF
                #!/bin/bash
                sudo apt-get update -y
                sudo apt-get install -y apache2
                sudo systemctl start apache2
                sudo systemctl enable apache2
                echo "<h1>Hello, World from $(hostname)</h1>" > /var/www/html/index.html
                EOF
    
    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "example" {
    launch_configuration = aws_launch_configuration.example.name
    vpc_zone_identifier  = [aws_subnet.public-main-1.id, aws_subnet.public-main-2.id]
    target_group_arns    = [aws_lb_target_group.asg.arn]
    health_check_type    = "ELB"
    min_size = 2
    max_size = 6
    
    tag {
        key                 = "Name"
        value               = "terraform-asg-instance"
        propagate_at_launch = true
    }
}