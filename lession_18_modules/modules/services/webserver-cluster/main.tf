data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# data "terraform_remote_state" "db" {
#     backend = "s3"

#     config = {
#         bucket         = "bucket-for-tf-state-from-erik-ubuntu"
#         key            = "global/s3/terraform.tfstate"
#         region         = "us-west-2"
#     }  
# }