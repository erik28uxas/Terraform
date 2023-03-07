variable "AWS_REGION" {
    default = "us-west-2"
}

# ==================================
variable "vpc_cidr" {
    description = "VPC CIDR block"
    value = "10.0.0.0/16"
  
}

variable "public_subnet_cidrs" {
    description = "Public Subnets CIDRs"
    type        = list
    default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_subnet_cidrs" {
    description = "Public Subnets CIDRs"
    type        = list
    default     = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
}