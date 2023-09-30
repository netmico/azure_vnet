resource "azurerm_resource_group" "az_resources" {
  name     = "DC_resource"
  location = "eastus"
}

resource "azurerm_express_route_circuit" "DC_circuit8923" {
  name                  = "expressRoute"
  resource_group_name   = azurerm_resource_group.az_resources.name
  location              = azurerm_resource_group.az_resources.location
  service_provider_name = "Equinix"
  peering_location      = "Silicon Valley"
  bandwidth_in_mbps     = 100

  sku {
    tier   = "Standard"
    family = "MeteredData"
  }

  tags = {
    environment = "Production"
  }
}





