resource "azurerm_route_table" "route-hub" {
  name                          = "routetohubfwfromprod"
  location                      = var.location
  resource_group_name           = azurerm_resource_group.rsg-hub.name
  disable_bgp_route_propagation = true

  route {
    name           = "route1"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "virtualAppliance"
    next_hop_in_ip_address = "10.101.242.4"
  }

  tags = {
    Environment  = var.environment
    Project = var.project
    Service = var.service
    Terraform = var.terraform
  }
}