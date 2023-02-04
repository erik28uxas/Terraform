# terraform {
#   backend "s3" {
#     bucket         = "bucket-for-tf-state-from-erik-ubuntu"
#     key            = "global/s3/terraform.tfstate"
#     region         = "us-west-2" 
#     dynamodb_table = "dynamodb-locks"
#     encrypt        = true
#   }
# }