provider "aws" {
    access_key = ""
    secret_key = ""
    region     = "us-west-2"
  
}
resource "aws_instance" "example" {
    ami           = "ami-0688ba7eeeeefe3cd"
    instance_type = "t2.micro"
}
