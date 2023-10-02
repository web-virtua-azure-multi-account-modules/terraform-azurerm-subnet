resource "azurerm_subnet" "create_subnet" {
  name                                          = var.name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = var.virtual_network_name
  address_prefixes                              = var.address_prefixes
  service_endpoints                             = var.service_endpoints
  service_endpoint_policy_ids                   = var.service_endpoint_policy_ids
  private_endpoint_network_policies_enabled     = var.private_link_endpoint_enabled
  private_link_service_network_policies_enabled = var.private_link_service_enabled

  dynamic "delegation" {
    for_each = var.delegation != null ? [1] : []

    content {
      name = var.delegation.name

      service_delegation {
        name    = var.delegation.service.name
        actions = var.delegation.service.actions
      }
    }
  }
}
