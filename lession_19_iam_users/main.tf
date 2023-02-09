provider "aws" {
    region = var.AWS_REGION
}

resource "aws_iam_user" "users_test" {
    count = length(var.user_names)
    name  = var.user_names[count.index]
}