provider "aws" {
    region = var.AWS_REGION
}


module "webserver_cluster" {
    source = "~/Documents/Terraform/lession_18_modules/modules/services/webserver-cluster"

    cluster_name           = "webservers-prod"
    db_remote_state_bucket = ""
    db_remote_state_key    = ""

    instance_type = "t2.micro"
    min_size      = 2
    max_size      = 10
}

