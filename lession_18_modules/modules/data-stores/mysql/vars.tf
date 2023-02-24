variable "db_username" {
    description = "Username for MySQL DB"
    type        = string
    sensitive   = true
    default     = null
}

variable "db_password" {
    description = "Password for MySQL DB"
    type        = string
    sensitive   = true
    default     = null
}

variable "db_name" {
  description = "The name to use for the database"
  type        = string
  default     = null
}

variable "db_instance_type" {
    description = "The type of DB Instance size "
    type        = string
}


variable "backup_retention_period" {
    description = "Days to retain backups. Must be > 0 to enable replication."
    type        = number
    default     = null  
}

variable "replicate_source_db" {
    description = "If specified, replicate the RDS database at the given ARN."
    type        = string
    default     = null
}