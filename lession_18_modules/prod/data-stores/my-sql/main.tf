terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 4.0"
    }
  }
}


provider "aws" {
    region = "us-west-2"
    alias  = "primary"
}

provider "aws" {
    region = "us-east-1"
    alias  = "replica"
}

module "mysql_db_prod" {
    source = "/home/erikgoul/Documents/Terraform/lession_18_modules/modules/data-stores/mysql"
    
    providers = {
        aws = aws.primary
     }

    db_name        = "prod_db"
    instance_class = "db.t2.micro"

    db_username = var.db_username
    db_password = var.db_password
    

    backup_retention_period = 1
}

module "mysql_replica" {
    source = "/home/erikgoul/Documents/Terraform/lession_18_modules/modules/data-stores/mysql"
    
    provider = aws.replica

    replicate_source_db = module.mysql_db_prod.arn
}
