provider "aws" {
    access_key = "AKIASCQC5CIQQJLSZZWN"
    secret_key = "eJgmlxH8+QzQCzU9y6O/SRJXXasdWOib1N1LIURA"
    region     = "us-west-2"
  
}
resource "aws_instance" "example" {
    ami           = "ami-0688ba7eeeeefe3cd"
    instance_type = "t2.micro"
}
