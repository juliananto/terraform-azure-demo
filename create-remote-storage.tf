terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "random_string" "resource_code" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "tfstate" {
  name     = "UKSPTERFRMRSG01"
  location = "UK South"
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "ukspterfrmsta01"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  allow_blob_public_access = true

  tags = {
    environment = "demo"
  }
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "terraformstatefile"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "blob"
}