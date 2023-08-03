#Create 3x Virtual machines
resource "azurerm_linux_virtual_machine" "R18_EUSDWEBVM1" {
  #Static
  admin_username        = "srinivas"
  admin_password = "Welcome@1234"
  disable_password_authentication = false
  location              = azurerm_resource_group.R1_RG.location
  resource_group_name   = azurerm_resource_group.R1_RG.name
  size                  = "Standard_B1s"
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  custom_data = filebase64("webserver.sh")
  #Dynamic
  name                  = "EUSDWEBVM1"
  network_interface_ids = [azurerm_network_interface.R12_EUSDWEBVM1-NIC.id]
  zone = "1"
}


resource "azurerm_linux_virtual_machine" "R19_EUSDWEBVM2" {
  #Static
  admin_username        = "srinivas"
  admin_password = "Welcome@1234"
  disable_password_authentication = false
  location              = azurerm_resource_group.R1_RG.location
  resource_group_name   = azurerm_resource_group.R1_RG.name
  size                  = "Standard_B1s"
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  custom_data = filebase64("webserver.sh")
  #Dynamic
  name                  = "EUSDWEBVM2"
  network_interface_ids = [azurerm_network_interface.R14_EUSDWEBVM2-NIC.id]
  zone = "2"
}

resource "azurerm_linux_virtual_machine" "R20_EUSDWEBVM3" {
  #Static
  admin_username        = "srinivas"
  admin_password = "Welcome@1234"
  disable_password_authentication = false
  location              = azurerm_resource_group.R1_RG.location
  resource_group_name   = azurerm_resource_group.R1_RG.name
  size                  = "Standard_B1s"
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
  custom_data = filebase64("webserver.sh")
  #Dynamic
  name                  = "EUSDWEBVM3"
  network_interface_ids = [azurerm_network_interface.R16_EUSDWEBVM3-NIC.id]
  zone = "3"
}