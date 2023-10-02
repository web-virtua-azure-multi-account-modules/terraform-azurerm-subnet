output "subnet" {
  description = "Subnet"
  value       = azurerm_subnet.create_subnet
}

output "subnet_id" {
  description = "Subnet ID"
  value       = azurerm_subnet.create_subnet.id
}

output "subnet_name" {
  description = "Subnet name"
  value       = azurerm_subnet.create_subnet.name
}

output "subnet_cidrs" {
  description = "CIDRs maps"
  value = azurerm_subnet.create_subnet.address_prefixes
}
