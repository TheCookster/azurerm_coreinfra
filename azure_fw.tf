resource "azurerm_firewall" "hub-azfw" {
  name                = "hod-ukw-prod-testinfra-azfw-hub"
  location            = var.location
  resource_group_name = azurerm_resource_group.rsg-hub.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.subnet-hub-azfw.id
    public_ip_address_id = azurerm_public_ip.pip-hub-azfw.id
  }
}

