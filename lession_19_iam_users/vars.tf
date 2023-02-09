variable "AWS_REGION" {
    default = "us-west-2"
}

variable "user_names" {
    description = "Creating IAM Users"
    type        = list(string)
    default     = ["Loba", "Wraith", "Valk"]
}