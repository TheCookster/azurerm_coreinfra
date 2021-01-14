#azure global variables
variable "prefix" {
  type = string
}

#environment variables

variable "location" {
  type = string
}

#network variables
variable "vnet_range-hub" {
  type = string
}

variable "vnet_range-partner" {
  type = string
}

variable "vnet_range-prod" {
  type = string
}

variable "subnet_range-hub" {
  type = string
}

variable "subnet_range-hub-vng" {
  type = string
}

variable "subnet_range-hub-azfw" {
  type = string
}

variable "subnet_range-partner" {
  type = string
}

variable "subnet_range-prod" {
  type = string
}

variable "subnet_range-partner-vng" {
  type = string
}

variable "subnet_range-prodaccess" {
  type = string
}

variable "subnet_range-prodnoaccess" {
  type = string
}




#Resource tags
variable "project" {
  type = string
}

variable "service" {
  type = string
}

variable "terraform" {
  type = string
}

variable "environment" {
  type = string
}

#VPN specifics

variable  "peer_address-hub" {
type = string
}

variable  "peer_address-partner" {
type = string
}

variable  "vpn_address_space-hub" {
type = string
}

variable  "vpn_address_space-partner" {
type = string
}

variable "shared_key" {
  type = string
}

variable "DHgroup" {
  type = string
}

variable "IKEenc" {
  type = string
}

variable "IKEinteg" {
  type = string
}

variable "IPSECenc" {
  type = string
}

variable "IPSECinteg" {
  type = string
}

variable "PFSgroup" {
  type = string
}

variable "SAdatasize" {
  type = string
}

variable "SAlifetime" {
  type = string
}

