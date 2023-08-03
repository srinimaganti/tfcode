resource "azurerm_resource_group" "R1_RG" {
  location = "EASTUS"
  name     = "EUSDEVRG"
}

resource "azurerm_resource_group" "R2_RG" {
  location = "WESTUS"
  name     = "WUSDEVRG-DR"
}