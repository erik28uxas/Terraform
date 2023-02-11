variable "legends" {
    description = "Names of legends"
    type = list(string)
    default = ["Loba", "Valk", "Ash"]
}

output "Lagend_names_upper" {
    value = [for name in var.legends : upper(name)]  
}