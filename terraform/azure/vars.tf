variable "rg_name" {
    type    = string
    default = "RG_VM_MULTI_CLOUD"
}

variable "location" {
    type    = string
    default = "EastUS"
}

variable "vnet_cidr" {
    type    = string
    default = "10.0.0.0/16"
}

variable "subnet_cidr" {
    type    = string
    default = "10.0.1.0/24"
}

variable "fqdn" {
    type    = string
    default = "staticsite-vm-kb"
}
