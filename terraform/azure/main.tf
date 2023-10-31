module "rg" {
    source   = "./modules/rg"
    rg_name  = "${var.rg_name}"
    location = "${var.location}"
}

module "rede" {
    source      = "./modules/rede"
    rg_name     = "${var.rg_name}"
    location    = "${var.location}"
    vnet_cidr   = "${var.vnet_cidr}"
    subnet_cidr = "${var.subnet_cidr}"
}

module "compute" {
    source    = "./modules/compute"
    rg_name   = "${var.rg_name}"
    location  = "${var.location}"
    subnet_id = "${module.rede.subnet_id}"
}