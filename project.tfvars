#project variables
location = "Uk West"
prefix = "hod-ukw-sandbox-hub-infra"

#network details
vnet_range-hub = "10.101.240.0/20"
vnet_range-partner = "10.100.240.0/20"
vnet_range-prod = "10.102.128.0/19"
subnet_range-hub = "10.101.240.0/24"
subnet_range-hub-vng = "10.101.241.0/27"
subnet_range-hub-azfw = "10.101.242.0/24"
subnet_range-partner = "10.100.241.0/24"
subnet_range-partner-vng = "10.100.242.0/27"
subnet_range-prod = "10.102.128.0/24"
subnet_range-prodaccess = "10.102.129.0/24"
subnet_range-prodnoaccess = "10.102.130.0/24"

#resource tags
environment = "sandbox"
service = "ITinfra"
project = "Testing"
terraform = "True"

#vpn
peer_address-hub = "1.2.3.4"
peer_address-partner = "1.2.3.4"

vpn_address_space-hub ="10.102.128.0/24"
vpn_address_space-partner ="10.100.240.0/24"
shared_key = "432989032859082390582385djkhfksj!!!!"
DHgroup = "DHGroup24"
IKEenc = "AES256"
IKEinteg = "SHA256"
IPSECenc = "AES256"
IPSECinteg = "SHA256"
PFSgroup = "PFS24"
SAdatasize = "102400000"
SAlifetime = "3600"

