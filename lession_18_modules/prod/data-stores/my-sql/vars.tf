variable "db_username" {
    description = "The username for the database" 
    type        = string
    sensitive   = true
}

variable "db_password" {
    description = "The password for the database" 
    type        = string
    sensitive   = true
}

# variable "db_instance_type" {
#     description = "The type of DB Instance size "
#     type        = string
#     default     = "db.t2.micro"
# }