provider "azurerm" {
#   skip_provider_registration = false # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {}
  use_cli  = false
  use_oidc = true
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = "6d1f906f-1e93-434a-b0be-aa8e373d335e"
  # client_secret   = var.oidc_client_secret
}

# Create a resource group
resource "azurerm_resource_group" "multiple_env" {
  name     = "multiple-env-${var.environment}"
  location = var.location
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "multiple_env" {
  name                = "multiple-env-${var.environment}-network"
  resource_group_name = azurerm_resource_group.multiple_env.name
  location            = azurerm_resource_group.multiple_env.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "multiple_env_prod" {
  name                 = "${var.environment}-management-zone"
  resource_group_name  = azurerm_resource_group.multiple_env.name
  virtual_network_name = azurerm_virtual_network.multiple_env.name
  address_prefixes     = ["10.0.1.0/24"]
}