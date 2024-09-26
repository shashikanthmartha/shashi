terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.3.0"
    }
  }
  backend "azurerm" {
  resource_group_name   = "first_rg"
  storage_account_name  = "shashiterraformstate"
  container_name        = "tfsatatefile"
  key                   = "terraform.tfstate"
}
}

provider "azurerm" {
  # Configuration options
}

