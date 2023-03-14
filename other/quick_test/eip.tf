resource "aws_eip" "nat" {
    count = 3
    vpc   = true

    tags = {
        Name = "EIP-for-Main-VPC-${count.index + 1} "
    }
}
