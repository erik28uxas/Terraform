terraform {
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 4.0"
    }
  }
}


provider "aws" {
    region = "us-west-2"
    alias  = "region_1"
}

provider "aws" {
    region = "us-east-1"
    alias  = "region_2"
}


data "aws_region" "region_1" {
    provider = aws.region_1
}

data "aws_region" "region_2" {
    provider = aws.region_2
}


data "aws_ami" "latest_amazon_ami_in_region_1" {
    provider = aws.region_1

    most_recent = true
    owners = ["137112412989"]

    filter {
        name = "name"
        values = ["al2022-ami-*-kernel-5.15-x86_64"]
    }
}

data "aws_ami" "latest_amazon_ami_in_region_2" {
    provider = aws.region_2

    most_recent = true
    owners = ["137112412989"]

    filter {
        name = "name"
        values = [ "al2022-ami-*-kernel-5.15-x86_64" ]
    }
}


resource "aws_instance" "region_1" {
    provider = aws.region_1

    ami           = data.aws_ami.latest_amazon_ami_in_region_1.id
    instance_type = var.instance_type

    tags = {
        Name = "exmpl-ec2-in-Oregon"
    }
}

resource "aws_instance" "region_2" {
    provider = aws.region_2
    
    ami           = data.aws_ami.latest_amazon_ami_in_region_2.id
    instance_type = var.instance_type

    tags = {
        Name = "exmpl-ec2-in-Virginia"
    }
}