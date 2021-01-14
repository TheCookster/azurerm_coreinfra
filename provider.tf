# Configure the Azure Provider
provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  #version = "=2.41.0"
  features {}
}

# Define Terraform provider
terraform {
  backend "azurerm" {
    resource_group_name  = "hod_ukw-tfstate-rg"
    storage_account_name = "hodgeazurermtfstate"
    container_name       = "coreinfra-tfstate"
    key                  = "terraform.tfstate"
  }
}

