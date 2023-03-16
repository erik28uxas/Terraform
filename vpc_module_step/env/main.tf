terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.73"
    }
  }
}

provider "aws" {
    region = local.region
}

locals {
  region = "us-west-2"

  tags = {
    ManagedBy = "Terraform"
  }
}


module "vpc" {
  source = "/home/erikgoul/Documents/Terraform/vpc_module_step/module"


  azs                 = ["${local.region}a", "${local.region}b", "${local.region}c"]
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  
  public_subnet_tags = {
    Name = "Main VPC public subnet ${count.index}"
  }

  public_subnet_tags_per_az = {
    "${local.region}a" = {
      "availability-zone" = "${local.region}a"
    }
    "${local.region}b" = {
      "availability-zone" = "${local.region}b"
    }
    "${local.region}c" = {
      "availability-zone" = "${local.region}c"
    }
  }


  vpc_tags = {
    Name = "Main VPC"
  }

  igw_tags = {
    Name = "Main VPC IGW"
  }


  tags = local.tags

}
