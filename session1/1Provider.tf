# Provider information for Azure Deployment
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.67.0"
    }
  }
}

#Az Authentication
provider "azurerm" {
  features {}
  client_id = "abcd"
  client_secret = "efgh"
  tenant_id = "ijkl"
  subscription_id = "mnop"
}
