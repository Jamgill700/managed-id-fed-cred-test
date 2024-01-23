terraform{
  cloud {
    organization = var.tfc_organization_name

    workspaces {
      name = var.tfc_workspace_name
    }
  }

  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.85.0"
    }
  }
} 
