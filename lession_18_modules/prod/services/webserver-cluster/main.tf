provider "aws" {
    region = var.AWS_REGION
}

# terraform {
#   backend "s3" {
#     bucket         = "bucket-for-tf-state-from-erik-ubuntu"
#     key            = "prod/services/webserver-cluster/terraform.tfstate"
#     region         = "us-west-2" 
#     dynamodb_table = "dynamodb-locks"
#     encrypt        = true
#   }
# }



module "webserver_cluster" {
    source = "/home/erikgoul/Documents/Terraform/lession_18_modules/modules/services/webserver-cluster"

    cluster_name           = "webservers-prod"
    db_remote_state_bucket = "bucket-for-tf-state-from-erik-ubuntu"
    db_remote_state_key    = "global/s3/terraform.tfstate"

    instance_type = "t2.micro"
    min_size      = 2
    max_size      = 10
}

