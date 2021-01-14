#Hub network resource group
resource "azurerm_resource_group" "rsg-hub" {
  name     = join("-", [var.prefix, "rsg-hub-network"])
  location = var.location
  tags = {
    Environment  = var.environment
    Project = var.project
    Service = var.service
    Terraform = var.terraform
  }
}

#Partner network resource group
resource "azurerm_resource_group" "rsg-partner" {
  name     = join("-", [var.prefix, "rsg-tp-network"])
  location = var.location
  
  tags = {
    Environment  = var.environment
    Project = var.project
    Service = var.service
    Terraform = var.terraform
  }
}

#Prod network resource group
resource "azurerm_resource_group" "rsg-prod" {
  name     = join("-", [var.prefix, "rsg-prod-network"])
  location = var.location
  tags = {
    Environment  = var.environment
    Project = var.project
    Service = var.service
    Terraform = var.terraform
  }
}

#Hub vnet
resource "azurerm_virtual_network" "vnet-hub" {
  name     = join("-", [var.prefix, "vnet-hub"])
  address_space       = [var.vnet_range-hub]
  location            = var.location
  resource_group_name = azurerm_resource_group.rsg-hub.name
  #depends_on          = [azurerm_resource_group.rsg-hub]
}

#Partner vnet
resource "azurerm_virtual_network" "vnet-partner" {
  name     = join("-", [var.prefix, "vnet-partner"])
  address_space       = [var.vnet_range-partner]
  location            = var.location
  resource_group_name = azurerm_resource_group.rsg-partner.name
  #depends_on           = [azurerm_resource_group.rsg-partner]
}
#Prod vnet
resource "azurerm_virtual_network" "vnet-prod" {
  name     = join("-", [var.prefix, "vnet-prod"])
  address_space       = [var.vnet_range-prod]
  location            = var.location
  resource_group_name = azurerm_resource_group.rsg-prod.name
  #depends_on           = [azurerm_resource_group.rsg-prod]
}

#Hub subnet for VM resources - with linked NSG
resource "azurerm_subnet" "subnet-hub" {
  name                 = "hod-ukw-prod-testinfra-snet-hub"
  resource_group_name  = azurerm_resource_group.rsg-hub.name
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  address_prefix       = var.subnet_range-hub
  #depends_on           = [azurerm_virtual_network.vnet-hub]
}
#Hub subnet for VPN gw
resource "azurerm_subnet" "subnet-hub-vng" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rsg-hub.name
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  address_prefix       = var.subnet_range-hub-vng
  #depends_on           = [azurerm_virtual_network.vnet-hub]
}
#Hub subnet for Azure firewall
resource "azurerm_subnet" "subnet-hub-azfw" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.rsg-hub.name
  virtual_network_name = azurerm_virtual_network.vnet-hub.name
  address_prefix       = var.subnet_range-hub-azfw
  #depends_on           = [azurerm_virtual_network.vnet-hub]
}

#Partner subnet for VM resources
resource "azurerm_subnet" "subnet-partner" {
  name                 = "hod-ukw-prod-testinfra-snet-partner"
  resource_group_name  = azurerm_resource_group.rsg-partner.name
  virtual_network_name = azurerm_virtual_network.vnet-partner.name
  address_prefix       = var.subnet_range-partner
  #network_security_group_id = azurerm_network_security_group.nsg-partner.id
  #depends_on           = [azurerm_virtual_network.vnet-partner]
}
#Partner subnet for VPN gw
resource "azurerm_subnet" "subnet-partner-vng" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.rsg-partner.name
  virtual_network_name = azurerm_virtual_network.vnet-partner.name
  address_prefix       = var.subnet_range-partner-vng
  #network_security_group_id = azurerm_network_security_group.nsg-partner.id
  #depends_on           = [azurerm_virtual_network.vnet-partner]
}

#Prod subnet for VM resources - acessible from partner
resource "azurerm_subnet" "subnet-prod-access" {
  name                 = "hod-ukw-prod-testinfra-snet-prodaccess"
  resource_group_name  = azurerm_resource_group.rsg-prod.name
  virtual_network_name = azurerm_virtual_network.vnet-prod.name
  address_prefix       = var.subnet_range-prodaccess
  #network_security_group_id = azurerm_network_security_group.nsg-prod.id
  #depends_on           = [azurerm_virtual_network.vnet-prod]
}

#Prod subnet for VM resources - inacessible from partner
resource "azurerm_subnet" "subnet-prod-noaccess" {
  name                 = "hod-ukw-prod-testinfra-snet-prodnoaccess"
  resource_group_name  = azurerm_resource_group.rsg-prod.name
  virtual_network_name = azurerm_virtual_network.vnet-prod.name
  address_prefix       = var.subnet_range-prodnoaccess
  #network_security_group_id = azurerm_network_security_group.nsg-prod.id
  #depends_on           = [azurerm_virtual_network.vnet-prod]
}

#Hub security group NSG
resource "azurerm_network_security_group" "nsg-hub" {
    name                = join("-", [var.prefix, "nsg-hub"])
    location            = var.location
    resource_group_name = azurerm_resource_group.rsg-hub.name
    }

#Partner security group NSG
resource "azurerm_network_security_group" "nsg-partner" {
    name                = join("-", [var.prefix, "nsg-partner"])
    location            = var.location
    resource_group_name = azurerm_resource_group.rsg-partner.name
    }

#Prod security group NSG
resource "azurerm_network_security_group" "nsg-prod" {
    name                = join("-", [var.prefix, "nsg-prod"])
    location            = var.location
    resource_group_name = azurerm_resource_group.rsg-prod.name
    }

#NSG associations with subnets
resource "azurerm_subnet_network_security_group_association" "subnet-hub" {
  subnet_id                 = azurerm_subnet.subnet-hub.id
  network_security_group_id = azurerm_network_security_group.nsg-hub.id
}

resource "azurerm_subnet_network_security_group_association" "subnet-partner" {
  subnet_id                 = azurerm_subnet.subnet-partner.id
  network_security_group_id = azurerm_network_security_group.nsg-partner.id
}

resource "azurerm_subnet_network_security_group_association" "subnet-prod-access" {
  subnet_id                 = azurerm_subnet.subnet-prod-access.id
  network_security_group_id = azurerm_network_security_group.nsg-prod.id
}

resource "azurerm_subnet_network_security_group_association" "subnet-prod-noaccess" {
  subnet_id                 = azurerm_subnet.subnet-prod-noaccess.id
  network_security_group_id = azurerm_network_security_group.nsg-prod.id
}

#Hub public IP for VPN gw
resource "azurerm_public_ip" "pip-hub" {
  name                         = join("-", [var.prefix, "pip-hub"])
  location                     = var.location
  resource_group_name          = azurerm_resource_group.rsg-hub.name
  allocation_method = "Dynamic"
}

#Hub Azure fw public IP
resource "azurerm_public_ip" "pip-hub-azfw" {
  name                         = join("-", [var.prefix, "pip-hub-azfw"])
  location                     = var.location
  resource_group_name          = azurerm_resource_group.rsg-hub.name
  allocation_method = "Static"
  sku = "Standard"
}

#Partner public IP
resource "azurerm_public_ip" "pip-partner" {
  name                         = join("-", [var.prefix, "pip-partner"])
  location                     = var.location
  resource_group_name          = azurerm_resource_group.rsg-partner.name
  allocation_method = "Dynamic"
}






