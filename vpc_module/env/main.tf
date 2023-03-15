terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.73"
    }
  }
}

variable "aws_region" {
    default = "us-west-2"
}

provider "aws" {
    region = var.aws_region
}


module "vpc" {
  source = "/home/erikgoul/Documents/Terraform/vpc_module/module"

  azs = ["${var.region}a", "${var.region}b", "${var.region}c"]
}