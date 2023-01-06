resource "aws_s3_bucket" "b" {
    bucket = "mybucket-2827-e"


    tags ={
        Name = "mybucket-2827-e"
    } 
}

resource "aws_s3_bucket_acl" "b-acl" {
    acl = "private"
  
}