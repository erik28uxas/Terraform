resource "aws_launch_configuration" "example-launchconfig" {
    name_prefix     = "example-launchconfig"
    image_id        = var.AMIS[var.AWS_REGION]
    instance_type   = "t2.micro"
    key_name        = aws_key_pair.id_rsa.key_name
    security_groups = [aws_security_group.allow-ssh.id]
}

resource "aws_autoscaling_group" "example-autoscaling" {
    name                      = "example-autocaling"
    vpc_zone_identifier       = [aws_subnet.public-main-1.id, aws_subnet.public-main-2.id]
    launch_configuration      = aws_launch_configuration.example-launchconfig.name
    min_size                  = 1
    max_size                  = 3
    health_check_grace_period = 300
    health_check_type         = "EC2"
    force_delete              = true


    tag {
      key                 = "Name"
      value               = "ec2 instance"
      propagate_at_launch = true
    }
}