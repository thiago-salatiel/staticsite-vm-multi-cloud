terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.78.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-staticsite-vm-tf"
    storage_account_name = "staticsitevmkbtf001"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
  # alias                      = "cloud"
}