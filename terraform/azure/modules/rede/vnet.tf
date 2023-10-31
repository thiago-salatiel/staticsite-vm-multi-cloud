resource "azurerm_virtual_network" "vnet" {
  name                = "staticsite-vm-vnet"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"
  address_space       = ["${var.vnet_cidr}"]

  subnet {
    name           = "staticsite-vm-subnet"
    address_prefix = "${var.subnet_cidr}"
  }
}