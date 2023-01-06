resource "aws_s3_bucket" "b" {
    bucket = "mybucket-2827-e"
    acl = "private"

    tags ={
        Name = "mybucket-2827-e"
    } 
}