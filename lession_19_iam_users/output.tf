output "iam_arns" {
    value = aws_iam_user.users_test[*].arn
    description = "Outputing all Created IAM Users "
}