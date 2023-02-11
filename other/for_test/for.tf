variable "legends_1" {
    description = "Names of legends"
    type = list(string)
    default = ["Loba", "Valk", "Ash"]
}

output "Legend_names_upper_list" {
    value = [for name in var.legends_1 : upper(name) if length(name) > 2]  
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

output "Legend_ultimates_list" {
    value = [for name, ult in var.legends_2 : "${name} has ${ult}"]  
}

output "Legend_ultimates_map" {
    description = "Outputing from Map 'legends_2' to Map"
    value = {for name, ult in var.legends_2 : upper(name) => upper(ult)}
}


variable "legends_3" {
    description = "Names of legends"
    type = list(string)
    default = [
        "Loba", "black market",
        "Valk", "jet pack",
        "Ash", "steel sword"
    ]
}

output "Legend_ultimates_list_2" {
    description = "Outputing from list 'legends_3' to Map"
    value = {for name in var.legends_3 : upper(name) => upper(ult)}
}
