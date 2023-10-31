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

# # module "compute" {
# #     source    = "./modules/compute"
# #     rede_id   = "${module.rede.vpc_id}"
# #     subnet_id = "${module.rede.subnet_id}"
# #     rede_cidr = "${var.rede_cidr}"
# #     ami       = "${var.ami}"
# # }