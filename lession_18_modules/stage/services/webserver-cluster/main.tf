provider "aws" {
    region = var.AWS_REGION
}

module "webserver_cluster" {
    source = "/home/erikgoul/Documents/Terraform/lession_18_modules/modules/services/webserver-cluster"

    cluster_name           = "webservers-stage"
    # db_remote_state_bucket = " " 
    # db_remote_state_key    = " "

    instancee_type     = "t1.micro"
    min_size           = 1
    max_size           = 2
    enable_autoscaling = true
}

resource "aws_security_group_rule" "some_test_inbound" {
    type              = "ingress"
    security_group_id = module.webserver_cluster.alb_security_gorup.id

    from_port   = 12345
    to_port     = 12345
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}