variable "aws_region" {
    default = "us-west-2"  
}


provider "aws" {
    region = var.aws_region
}


resource "aws_instance" "example" {
  ami = "ami-0688ba7eeeeefe3cd"
  instance_type = "t2.micro"

  ebs_block_device {
    device_name = "sda2"
    volume_size = 2
  }
  
  ebs_block_device {
    device_name = "sda3"
    volume_size = 4
  } 
}

output "ebs_blocks" {
    value = ws_instance.example.ebs_block_device.*.volume_id
}
