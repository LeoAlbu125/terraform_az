provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name   = "test"      
    storage_account_name  = "bucketazulzure"
    container_name        = "terraform-container"          
    key                   = "terraform.tfstate"  
  }
}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}
