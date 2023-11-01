terraform {
  required_providers {
    # azapi = {
    #   source  = "azure/azapi"
    #   version = ">= 1.9"
    # }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.78.0"
    }
    # random = {
    #   source  = "hashicorp/random"
    #   version = ">= 3.5"
    # }
  }
  backend "azurerm" {
    resource_group_name  = "RG_VM_MULTI_CLOUD"
    storage_account_name = "rm551050"
    container_name       = "vm-multi-cloud"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
  skip_provider_registration = true
}

# provider "azapi" {
# }