# Azure Subnet for multiples accounts with Terraform module
* This module simplifies creating and configuring of Subnet across multiple accounts on Azure

* Is possible use this module with one account using the standard profile or multi account using multiple profiles setting in the modules.

## Actions necessary to use this module:

* Criate file provider.tf with the exemple code below:
```hcl
provider "azurerm" {
  alias   = "alias_profile_a"

  features {}
}

provider "azurerm" {
  alias   = "alias_profile_b"

  features {}
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}
```


## Features enable of Subnet configurations for this module:

- Subnet

## Usage exemples


### Create Subnet

```hcl
module "subnet_test" {
  source = "web-virtua-azure-multi-account-modules/subnet/azurerm"

  name                 = "tf-test-subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.1.0/24"]
  
  delegation = {
    name = "delegation"
    service = {
      name    = "Microsoft.ContainerInstance/containerGroups"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
    }
  }

  providers = {
    azurerm = azurerm.alias_profile_b
  }
}
```

## Variables

| Name | Type | Default | Required | Description | Options |
|------|-------------|------|---------|:--------:|:--------|
| name | `string` | `-` | yes | Subnet name | `-` |
| resource_group_name | `string` | `-` | yes | Resource group name | `-` |
| virtual_network_name | `string` | `-` | yes | Virtual network name to which to attach the subnet | `-` |
| address_prefixes | `list(string)` | `["10.0.1.0/24"]` | no | The list of address spaces or ip adresses used by the virtual network, it looks like the CIDR BLOCK, but to many IPs | `-` |
| service_endpoints | `list(string)` | `[]` | no | The list of Service endpoints to associate with the subnet, the values can be Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage, Microsoft.Storage.Global and Microsoft.Web | `*`Microsoft.AzureActiveDirectory <br> `*`Microsoft.AzureCosmosDB `*`Microsoft.ContainerRegistry <br> `*`Microsoft.EventHub `*`Microsoft.KeyVault <br> `*`Microsoft.ServiceBus `*`Microsoft.Sql <br> `*`Microsoft.Storage <br> `*`Microsoft.Storage.Global <br> `*`Microsoft.Storage.Web |
| service_endpoint_policy_ids | `list(string)` | `-` | no | The list of IDs of Service Endpoint Policies to associate with the subnet | `-` |
| private_link_endpoint_enabled | `bool` | `true` | no | Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true | `*`false <br> `*`true |
| private_link_service_enabled | `bool` | `true` | no | Enable or Disable network policies for the private link service on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Defaults to true | `*`false <br> `*`true |
| delegation | `object` | `null` | no | Delegation configuration | `-` |


## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.create_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |

## Outputs

| Name | Description |
|------|-------------|
| `subnet` | Subnet |
| `subnet_id` | Subnet ID |
| `subnet_name` | Subnet name |
| `subnet_cidrs` | CIDRs maps |
