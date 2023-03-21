# resource "aws_eip" "nat" {
#     count = 3
#     vpc   = true

#     tags = {
#         Name = "EIP-for-Main-VPC-${count.index + 1} "
#     }
# }


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
    value = aws_instance.example.ebs_block_device[*].id  
}