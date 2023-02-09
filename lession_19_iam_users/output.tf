output "iam_arns_all" {
    value = values(aws_iam_user.users_test)[*].arn
    description = "Outputing all Created IAM Users "
}