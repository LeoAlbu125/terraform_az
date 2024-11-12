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

# Azure Storage Account
resource "azurerm_storage_account" "example" {
  name                     = "storageblob212324"
  resource_group_name       = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location
  account_tier               = "Standard"
  account_replication_type = "LRS"
}

# Azure Blob Storage Container
resource "azurerm_storage_container" "example" {
  name                    = "example-container"
  storage_account_name    = azurerm_storage_account.example.name
}

# Create a virtual directory called "results" (simulated using blob naming convention)

resource "azurerm_storage_blob" "results_directory" {
  name                    = "results/.dummy"  # This creates the 'results' folder structure.
  storage_account_name    = azurerm_storage_account.example.name
  storage_container_name  = azurerm_storage_container.example.name
  type                    = "Block"
}

