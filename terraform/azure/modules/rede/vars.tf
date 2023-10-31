variable "rg_name" {
    type    = string
    default = "rg-default"
}

variable "location" {
    type    = string
    default = "eastus"
}

variable "vnet_cidr" {
    type    = string
    default = "10.0.0.0/16"
}

variable "subnet_cidr" {
    type    = string
    default = "10.0.1.0/24"
}