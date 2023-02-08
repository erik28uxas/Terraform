variable "AWS_REGION" {
    default = "us-west-2"
}

# ==================================================
variable "PATH_TO_PRIVATE_KEY" {
    default = "/home/erikgoul/.ssh/id_rsa"
}
variable "PATH_TO_PUBLIC_KEY" {
    default = "/home/erikgoul/.ssh/id_rsa.pub"
}

variable "AMIS" {
    type    = map(string)
    default = {
        us-west-2 = "ami-0688ba7eeeeefe3cd"
    }
}

# ==================================================
variable "server_port" {
    description = "The port the server will use for HTTP requests" 
    type        = number
    default     = 80
}

# ==================================================
# ================= Related to ASG =================
# ==================================================
variable "instance_type" {
    description = "The type of EC2 Instance to run"
    type        = string
}

variable "min_size" {
    description = "The minimum number of EC2 in ASG"
    type        = number
}

variable "max_size" {
    description = "The minimum number of EC2 in ASG"
    type        = number
}

# ==================================================
variable "cluster_name" {
    description = "The name to use for all the cluster resources"
    type        = string
}

variable "db_remote_state_bucket" {
    description = "The name of the S3 bucket for the database's remote state"
    type        = string
}

# variable "db_remote state_key" {
#     description = "The path for the database's remote state in S3"
#     type        = string
# }


# ==================================================
# ===================== Locals =====================
# ==================================================

locals {
  http_port    = 80
  ssh_port     = 22
  any_port     = 0
  any_protocol ="-1"
  tcp_protoxol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}