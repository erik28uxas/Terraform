provider "aws" {
    region = "us-west-2"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"  
}

esource "aws_s3_bucket" "bucket-tf-state" {
    bucket = "bucket-for-tf-state-from-erik-ubuntu"
    force_destroy = true
    
    lifecycle {
      prevent_destroy = false
    }
}

resource "aws_s3_bucket_versioning" "enable" {
    bucket = aws_s3_bucket.bucket-tf-state.id
    versioning_configuration {
        status = "Enabled"
    }
}

terraform {
  backend "s3" {
    bucket = "bucket-for-tf-state-from-erik-ubuntu"
    key    = "dev/network/terraform.tfstate"
    region = "us-west-2"
    
  }
}


resource "aws_vpc" "test" {
    cidr_block = var.vpc_cidr

    tags ={
        Name = "Test VPC"
    }  
}



