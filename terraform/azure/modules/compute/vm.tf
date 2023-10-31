resource "azurerm_public_ip" "public-ip" {
  name                = "staticsite-vm-public-ip"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"
  allocation_method   = "Dynamic"
}

resource "azurerm_network_security_group" "nsg" {
  name                = "staticsite-vm-nsg"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"
  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "HTTP"
    priority                   = 1021
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "nic" {
  name                = "staticsite-vm-nic"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"
  ip_configuration {
    name                          = "ip-config"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public-ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "nic-to-nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# resource "azurerm_linux_virtual_machine" "vm" {
#   name                  = "staticsite-vm"
#   location            = "${var.location}"
#   resource_group_name = "${var.rg_name}"
#   network_interface_ids = [azurerm_network_interface.nic.id]
#   size                  = "Standard_DS1_v2"
#   os_disk {
#     name                 = "OsDisk"
#     caching              = "ReadWrite"
#     storage_account_type = "Premium_LRS"
#   }
#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts-gen2"
#     version   = "latest"
#   }
#   computer_name  = "staticsite-vm"
#   admin_username = var.username
#   admin_ssh_key {
#     username   = var.username
#     public_key = jsondecode(azapi_resource_action.ssh_public_key_gen.output).publicKey
#   }
#   # boot_diagnostics {
#   #   storage_account_uri = azurerm_storage_account.my_storage_account.primary_blob_endpoint
#   # }
# }

resource "azurerm_virtual_machine" "vm" {
  name                             = "staticsite-vm"
  location                         = "${var.location}"
  resource_group_name              = "${var.rg_name}"
  network_interface_ids            = [azurerm_network_interface.nic.id]
  vm_size                          = "Standard_DS1_v2"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "staticsite-vm-disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "staticsite-vm"
    admin_username = "vmuser"
    admin_password = "Password1234!"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}