resource "aws_launch_configuration" "example" {
    image_id        = var.AMIS[var.AWS_REGION]
    instance_type   = var.instance_type
    key_name        = aws_key_pair.id_rsa.key_name
    security_groups = [aws_security_group.instance.id]
    user_data       = "${file("/home/erikgoul/Documents/Terraform/lession_18_modules/modules/services/webserver-cluster/user-data.sh")}"
    
    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "example" {
    name                 = var.cluster_name
    launch_configuration = aws_launch_configuration.example.name
    vpc_zone_identifier  = data.aws_subnets.default.ids
    target_group_arns    = [aws_lb_target_group.asg.arn]
    health_check_type    = "ELB"
    
    # min_elb_capacity = var.min_size

    min_size = var.min_size
    max_size = var.max_size

    # lifecycle {
    #   create_before_destroy = true
    # }

    instance_refresh {
        strategy = "Rolling"
        preferences {
            min_healthy_percentage = 50
        }
    }
    
    tag {
        key                 = "Name"
        value               = var.cluster_name
        propagate_at_launch = true
    }
}