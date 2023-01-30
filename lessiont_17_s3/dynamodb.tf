resource "aws_dynamodb_table" "tf-locks" {
    name         = "dynamodb-locks"
    billing_mode = "PER_PER_REQUEST"
    hash_key     = "LockID"

    attribute {
      name = "LockID"
      type = "S"
    }
}