provider "aws" {
    access_key = "AKIAX3QMCJS7EK6OSKHR"
    secret_key = "C00XWZ8on2hTIkaJ7tCj0vGcxBNxPzjv3opxU0TR"
    region     = "us-east-1"
}

resource "aws_instance" "example" {
    ami           = "ami-0b0ea68c435eb488d"
    instance_type = "t2.micro"
  
}