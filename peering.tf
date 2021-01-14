#Peering within the same subscription

resource "azurerm_virtual_network_peering" "hub-peer-prod" {
  name                      = join("-", [var.prefix, "hub-peer"])
  resource_group_name       = azurerm_resource_group.rsg-hub.name
  virtual_network_name      = azurerm_virtual_network.vnet-hub.name
  remote_virtual_network_id = azurerm_virtual_network.vnet-partner.id

  #allow_virtual_network_access = true
  #allow_forwarded_traffic      = true
  #allow_gateway_transit        = true
  #use_remote_gateways          = false
  depends_on = [azurerm_virtual_network.vnet-hub, azurerm_virtual_network.vnet-prod, azurerm_virtual_network_gateway.vpn-hub]
}

resource "azurerm_virtual_network_peering" "prod-peer-hub" {
  name                         = join("-", [var.prefix, "prod-peer"])
  resource_group_name          = azurerm_resource_group.rsg-prod.name
  virtual_network_name         = azurerm_virtual_network.vnet-prod.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet-hub.id
  
  #allow_virtual_network_access = true
  #allow_forwarded_traffic      = true
  #allow_gateway_transit        = false
  #use_remote_gateways          = true
  depends_on = [azurerm_virtual_network.vnet-hub, azurerm_virtual_network.vnet-prod, azurerm_virtual_network_gateway.vpn-hub]
}