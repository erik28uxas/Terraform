resource "aws_s3_bucket" "b" {
    bucket = "mybucket-2827-e"


    tags ={
        Name = "mybucket-2827-e"
    } 
}

# resource "aws_s3_bucket_acl" "b-acl" {
#     bucket = aws_s3_bucket.b.id
#     acl = "private"
  
# }