variable "AWS_REGION" {
    default = "us-west-2"
}

variable "AMIS" {
    type = map(string)
    default = {
        us-west-2 = "ami-0688ba7eeeeefe3cd"
        us-west-1 = "ami-0454207e5367abf01"
    }
}

variable "PATH_TO_KEY" {
    default = "/home/erikgoul/.ssh/us-west-2-key.pem"
}
