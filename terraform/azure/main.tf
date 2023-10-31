module "resource_group" {
    source      = "./modules/resource_group"
    rg_name     = "${var.rg_name}"
    rg_location = "${var.rg_location}"
}

# module "rede" {
#     source      = "./modules/rede"
#     # rede_cidr   = "${var.rede_cidr}"
#     # subnet_cidr = "${var.subnet_cidr}"
# }

# # module "compute" {
# #     source    = "./modules/compute"
# #     rede_id   = "${module.rede.vpc_id}"
# #     subnet_id = "${module.rede.subnet_id}"
# #     rede_cidr = "${var.rede_cidr}"
# #     ami       = "${var.ami}"
# # }