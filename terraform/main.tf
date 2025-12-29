provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "AKS-RG-New1"
  location = "Central India"
}

resource "azurerm_container_registry" "acr" {
  name                = "ghademoacr123"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-gha-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksdemo"

  default_node_pool {
    name       = "system"
    node_count = 1
    vm_size    = "standard_d2ds_v5"
  }

  identity {
    type = "SystemAssigned"
  }
}

