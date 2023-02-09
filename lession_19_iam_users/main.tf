provider "aws" {
    region = var.AWS_REGION
}

resource "aws_iam_user" "users_test" {
    for_each = toset(var.user_names)
    name  = each.value
}