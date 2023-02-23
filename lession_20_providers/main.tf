terraform {
  required_providers {
    aws = {
        soursource  = "hashicorp/aws"
        versversion = "~> 4.0"
    }
  }
}


provider "aws" {
    region = "us-east-2"
    alias  = "region_1"
}

provider "aws" {
    region = "us-west-1"
    alias  = "region_2"
}


data "aws_region" "region_1" {
    provider = aws.region_1
}

data "aws_region" "region_2" {
    provider = aws.region_2
}


output "region_1" {
    value       = data.aws_region.region_1.name
    description = "The name of 1st region"
}

output "region_2" {
    value       = data.aws_region.region_2.name
    description = "The name of 2nd region"
}