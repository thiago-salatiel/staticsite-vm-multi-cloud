variable "rede_cidr" {
    type    = string
    default = "10.0.0.0/16"
}

variable "subnet_cidr" {
    type    = string
    default = "10.0.1.0/24"
}

variable "ami" {
    type    = string
    default = "ami-01eccbf80522b562b"
}
