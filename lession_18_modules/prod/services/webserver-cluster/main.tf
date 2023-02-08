provider "aws" {
    region = var.AWS_REGION
}

terraform {
  backend "s3" {
    bucket         = "bucket-for-tf-state-from-erik-ubuntu"
    key            = "prod/services/webserver-cluster/terraform.tfstate"
    region         = "us-west-2" 
  }
}

data "terraform_remote_state" "main-info" {
    backend = "s3"
    config = {
        bucket         = "bucket-for-tf-state-from-erik-ubuntu"
        key            = "global/s3/terraform.tfstate"
        region         = "us-west-2" 
    }
}

module "webserver_cluster" {
    source = "/home/erikgoul/Documents/Terraform/lession_18_modules/modules/services/webserver-cluster"

    cluster_name           = "webservers-prod"
    db_remote_state_bucket = "bucket-for-tf-state-from-erik-ubuntu"
    # db_remote_state_key    = "prod/services/webserver-cluster/terraform.tfstate"

    instance_type = "t2.micro"
    min_size      = 2
    max_size      = 10
}

