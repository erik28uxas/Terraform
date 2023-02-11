variable "legends_1" {
    description = "Names of legends"
    type = list(string)
    default = ["Loba", "Valk", "Ash"]
}

output "Legend_names_upper" {
    value = [for name in var.legends_1 : upper(name) if length(name) > 3]  
}

variable "legends_2" {
    description = "Names of legends"
    type = map(string)
    default = {
        Loba = "black market"
        Valk = "jet pack" 
        Ash  = "steel sword"
    }
}

output "Legend_ultimates" {
    value = [for name, specs in var.legends_2 : "${name} has ${specs}"]  
}
