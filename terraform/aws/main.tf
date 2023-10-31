module "rede" {
    source      = "./modules/rede"
    rede_cidr   = "10.0.0.0/16"
    subnet_cidr = "10.0.1.0/24"
}

# module "ec2" {
#     source    = "./modules/ec2"
#     rede_id   = "${module.rede.vpc_id}"
#     rede_cidr = "20.0.0.0/16"
#     ami       = "ami-0f409bae3775dc8e5"
#     subnet_id = "${module.rede.subnet_id}"
# }
