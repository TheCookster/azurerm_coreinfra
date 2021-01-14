#Hub virtual network gw
resource "azurerm_virtual_network_gateway" "vpn-hub" {
  name                = "hod-ukw-prod-testinfra-vng-hub"
  resource_group_name = azurerm_resource_group.rsg-hub.name
  location            = var.location

  type = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.pip-hub.id
    subnet_id                     = azurerm_subnet.subnet-hub-vng.id
  }
  #depends_on           = [azurerm_virtual_network.vnet-hub]
}

#Partner virtual network gw
resource "azurerm_virtual_network_gateway" "vpn-partner" {
  name                = "hod-ukw-prod-testinfra-vng-partner"
  resource_group_name = azurerm_resource_group.rsg-partner.name
  location            = var.location

  type = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.pip-partner.id
    subnet_id                     = azurerm_subnet.subnet-partner-vng.id
  }
}

#Hub VPN connection from hub-partner
resource "azurerm_virtual_network_gateway_connection" "conn-partner" {
  name                = "hod-ukw-prod-testinfra-con-partner"
  location            = var.location
  resource_group_name = azurerm_resource_group.rsg-hub.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn-hub.id
  local_network_gateway_id   = azurerm_local_network_gateway.vpn-lng-partner.id

  shared_key = var.shared_key

ipsec_policy {
      dh_group         = var.DHgroup
      ike_encryption   = var.IKEenc
      ike_integrity    = var.IKEinteg
      ipsec_encryption = var.IPSECenc
      ipsec_integrity  = var.IPSECinteg
      pfs_group        = var.PFSgroup
      sa_datasize      = var.SAdatasize
      sa_lifetime      = var.SAlifetime
  }
}

#Partner VPN connection from partner-hub
resource "azurerm_virtual_network_gateway_connection" "conn-hub" {
  name                = "hod-ukw-prod-testinfra-con-hub"
  location            = var.location
  resource_group_name = azurerm_resource_group.rsg-partner.name

  type                       = "IPsec"
  virtual_network_gateway_id = azurerm_virtual_network_gateway.vpn-partner.id
  local_network_gateway_id   = azurerm_local_network_gateway.vpn-lng-hub.id

  shared_key = var.shared_key

ipsec_policy {
      dh_group         = var.DHgroup
      ike_encryption   = var.IKEenc
      ike_integrity    = var.IKEinteg
      ipsec_encryption = var.IPSECenc
      ipsec_integrity  = var.IPSECinteg
      pfs_group        = var.PFSgroup
      sa_datasize      = var.SAdatasize
      sa_lifetime      = var.SAlifetime
  }
}

#Hub local network gw
resource "azurerm_local_network_gateway" "vpn-lng-hub" {
  name                = "Hod-ukw-prod-testinfra-lng-hub"
  resource_group_name = azurerm_resource_group.rsg-hub.name
  location            = var.location
  gateway_address     = "1.2.3.4"
  address_space       = [var.vpn_address_space-hub]
}

#Partner local network gw
resource "azurerm_local_network_gateway" "vpn-lng-partner" {
  name                = "hod-ukw-prod-testinfra-lng-partner"
  resource_group_name = azurerm_resource_group.rsg-partner.name
  location            = var.location
  gateway_address     = "1.2.3.4"
  address_space       = [var.vpn_address_space-partner]
}
