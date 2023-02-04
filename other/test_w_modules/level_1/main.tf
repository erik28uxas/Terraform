provider "aws" {
    region = "us-west-2"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"  
}

resource "aws_s3_bucket" "bucket-tf-state" {
    bucket = "bucket-for-tf-state-from-erik-ubuntu-test"

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

resource "aws_s3_bucket_server_side_encryption_configuration" "enabled-sse" {
    bucket = aws_s3_bucket.bucket-tf-state.id
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }  
}

resource "aws_s3_bucket_public_access_block" "public-access" {
    bucket                  = aws_s3_bucket.bucket-tf-state.id
    block_public_acls       = true 
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
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



