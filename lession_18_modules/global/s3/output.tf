output "s3_bucket_arn" {
    value = aws_s3_bucket.bucket-tf-state.arn
    description = "The ARN of bucket"
}

output "dynamodb_tabel_name" {
    value = aws_dynamodb_table.tf-locks.name
    description = "The NAMEe of DynamoDB Table"
}

# variable "db_remote_state_bucket" {
#     description = "value"
#     type = string
#     default = "value"
  
# }