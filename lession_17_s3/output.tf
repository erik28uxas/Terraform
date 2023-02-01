output "s3_bucket_arn" {
    value = aws_s3_bucket.bucket-tf-state.arn
    description = "The ARN of bucket"
}

output "dynamodb_tabl_name" {
    value = aws_dynamodb_table.tf-locks.name
    description = "The NAMEe of DynamoDB Table"
}

