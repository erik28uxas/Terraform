variable "AWS_REGION" {
    default = "us-west-2"
}

variable "bucket_name" {
    description = "The name of S3 bucket."
    type        = string
    default     = "bucket-for-tf-state-from-erik-ubuntu"
}

variable "table_name" {
    description = "The name of DynamoDB Table"
    type        = string
    default     = "dynamodb-locks"
}
