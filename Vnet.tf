resource "azurerm_virtual_network" "adc_vnet" {
  name                = "adc-network"
  resource_group_name = azurerm_resource_group.az_resources.name
  location            = azurerm_resource_group.az_resources.location
  address_space       = ["10.92.0.0/16"]
  tags = {
    environement = "dev"

  }
}

resource "azurerm_subnet" "subnet_1" {
  name                 = "VLAN_1"
  resource_group_name  = azurerm_resource_group.az_resources.name
  virtual_network_name = azurerm_virtual_network.adc_vnet.name
  address_prefixes     = ["10.92.1.0/24", "10.92.2.0/24"]
}

resource "azure_network_security_group" "adc_sec_gr" {
  resource_group_name = azurerm_resource_group.az_resources.name
  location            = azurerm_resource_group.az_resources.location
}

resource "azurerm_network_security_rule" "inbound_rule" {

  security_rule {
    name                        = "dev_sec"
    priority                    = 100
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "*"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
    resource_group_name         = azurerm_resource_group.az_resources.name
    network_security_group_name = azure_network_security_group.adc_sec_gr.name
  }
  tags = {
    environement = "dev"
  }
}

resource "azurerm_subnet_network_security_group_association" "adc_sec_assoc" {
  subnet_id                 = azurerm_subnet.subnet_1.id
  network_security_group_id = azurerm_network_security_group.adc_sec_gr.id
}



