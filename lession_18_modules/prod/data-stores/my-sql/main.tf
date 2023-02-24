provider "aws" {
    region = "us-west-2"
    alias  = "primary"
}

provider "aws" {
    region = "us-east-1"
    alias  = "replica"
}


module "mysql_db" {
    source = "/home/erikgoul/Documents/Terraform/lession_18_modules/modules/data-stores/mysql"
    
    providers = {
      aws = aws.primary
    }

    db_name     = "prod_db"
    db_username = var.db_username
    db_password = var.db_password

    backup_retention_period = 1
}

module "mysql_replica" {
    source = "/home/erikgoul/Documents/Terraform/lession_18_modules/modules/data-stores/mysql"
    
    providers = {
      aws = aws.replica
     }

    replicate_source_db = module.mysql_db.arn
}