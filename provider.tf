terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.3.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
}

  backend "s3" {
    bucket = "shashikanth-s3"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}


