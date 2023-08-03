#Create Virtual Network with 3x SUbnets
resource "azurerm_virtual_network" "R3_EUSDEVVNET" {
  address_space       = ["10.10.0.0/16"]
  location            = azurerm_resource_group.R1_RG.location
  name                = "EUSDEVVNET"
  resource_group_name = azurerm_resource_group.R1_RG.name
}

resource "azurerm_subnet" "R4_WEBSUBNET" {
  #location = azurerm_resource_group.R1_RG.location
  name     = "WEBSUBNET"
  address_prefixes = ["10.10.10.0/24"]
  resource_group_name = azurerm_resource_group.R1_RG.name
  virtual_network_name = azurerm_virtual_network.R3_EUSDEVVNET.name
}

resource "azurerm_subnet" "R5_APPSUBNET" {
  #location = azurerm_resource_group.R1_RG.location
  name     = "APPSUBNET"
  address_prefixes = ["10.10.20.0/24"]
  resource_group_name = azurerm_resource_group.R1_RG.name
  virtual_network_name = azurerm_virtual_network.R3_EUSDEVVNET.name
}

resource "azurerm_subnet" "R6_DBSUBNET" {
  #location = azurerm_resource_group.R1_RG.location
  name     = "DBSUBNET"
  address_prefixes = ["10.10.30.0/24"]
  resource_group_name = azurerm_resource_group.R1_RG.name
  virtual_network_name = azurerm_virtual_network.R3_EUSDEVVNET.name
}

# Create 4x Public IPS
resource "azurerm_public_ip" "R7_EUSDWEBVM1-PIP" {
  allocation_method   = "Static"
  location            = azurerm_resource_group.R1_RG.location
  name                = "EUSDWEBVM1-PIP"
  resource_group_name = azurerm_resource_group.R1_RG.name
  sku = "Standard"
  zones = ["1"]
}
resource "azurerm_public_ip" "R8_EUSDWEBVM2-PIP" {
  allocation_method   = "Static"
  location            = azurerm_resource_group.R1_RG.location
  name                = "EUSDWEBVM2-PIP"
  resource_group_name = azurerm_resource_group.R1_RG.name
  sku = "Standard"
  zones = ["2"]
}
resource "azurerm_public_ip" "R9_EUSDWEBVM3-PIP" {
  allocation_method   = "Static"
  location            = azurerm_resource_group.R1_RG.location
  name                = "EUSDWEBVM3-PIP"
  resource_group_name = azurerm_resource_group.R1_RG.name
  sku = "Standard"
  zones = ["3"]
}
resource "azurerm_public_ip" "R10_EUSDSLB-PIP" {
  allocation_method   = "Static"
  location            = azurerm_resource_group.R1_RG.location
  name                = "EUSDSLB-PIP"
  resource_group_name = azurerm_resource_group.R1_RG.name
  sku = "Standard"
}

#Create 1xNSG
resource "azurerm_network_security_group" "R11_EUSDEVNSG" {
  location            = azurerm_resource_group.R1_RG.location
  name                = "EUSDEVNSG"
  resource_group_name = azurerm_resource_group.R1_RG.name
  security_rule {
    access    = "Allow"
    direction = "Inbound"
    name      = "SSH"
    priority  = 100
    protocol  = "Tcp"
    source_address_prefix = "*"
    destination_address_prefix = "*"
    source_port_range = "*"
    destination_port_range = "22"
  }
  security_rule {
    access    = "Allow"
    direction = "Inbound"
    name      = "HTTP"
    priority  = 101
    protocol  = "Tcp"
    source_address_prefix = "*"
    destination_address_prefix = "*"
    source_port_range = "*"
    destination_port_range = "80"
  }
}

#Create 3xNIC CARDS for 3 VM's
resource "azurerm_network_interface" "R12_EUSDWEBVM1-NIC" {
  location            = azurerm_resource_group.R1_RG.location
  name                = "EUSDWEBVM1-NIC"
  resource_group_name = azurerm_resource_group.R1_RG.name
  ip_configuration {
    name                          = "EUSDWEBVM1-NIC_config"
    private_ip_address_allocation = "Dynamic"
    subnet_id = azurerm_subnet.R4_WEBSUBNET.id
    public_ip_address_id = azurerm_public_ip.R7_EUSDWEBVM1-PIP.id
  }
}

resource "azurerm_network_interface_security_group_association" "R13_EUSDWEBVM1_ASS1" {
  network_interface_id      = azurerm_network_interface.R12_EUSDWEBVM1-NIC.id
  network_security_group_id = azurerm_network_security_group.R11_EUSDEVNSG.id
}

resource "azurerm_network_interface" "R14_EUSDWEBVM2-NIC" {
  location            = azurerm_resource_group.R1_RG.location
  name                = "EUSDWEBVM2-NIC"
  resource_group_name = azurerm_resource_group.R1_RG.name
  ip_configuration {
    name                          = "EUSDWEBVM2-NIC_config"
    private_ip_address_allocation = "Dynamic"
    subnet_id = azurerm_subnet.R4_WEBSUBNET.id
    public_ip_address_id = azurerm_public_ip.R8_EUSDWEBVM2-PIP.id
  }
}

resource "azurerm_network_interface_security_group_association" "R15_EUSDWEBVM2_ASS1" {
  network_interface_id      = azurerm_network_interface.R14_EUSDWEBVM2-NIC.id
  network_security_group_id = azurerm_network_security_group.R11_EUSDEVNSG.id
}

resource "azurerm_network_interface" "R16_EUSDWEBVM3-NIC" {
  location            = azurerm_resource_group.R1_RG.location
  name                = "EUSDWEBVM3-NIC"
  resource_group_name = azurerm_resource_group.R1_RG.name
  ip_configuration {
    name                          = "EUSDWEBVM3-NIC_config"
    private_ip_address_allocation = "Dynamic"
    subnet_id = azurerm_subnet.R4_WEBSUBNET.id
    public_ip_address_id = azurerm_public_ip.R9_EUSDWEBVM3-PIP.id
  }
}

resource "azurerm_network_interface_security_group_association" "R17_EUSDWEBVM3_ASS1" {
  network_interface_id      = azurerm_network_interface.R16_EUSDWEBVM3-NIC.id
  network_security_group_id = azurerm_network_security_group.R11_EUSDEVNSG.id
}