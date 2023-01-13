variable "AWS_REGION" {
    default = "us-west-2"  
}


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
        us-west-1 = "ami-0454207e5367abf01"
    }
}