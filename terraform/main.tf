terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"
    storage_account_name = "ghademotfstate123"
    container_name       = "tfstate"
    key                  = "github-actions/terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

# ================================
# EXISTING RESOURCE GROUP
# ================================
resource "azurerm_resource_group" "rg" {
  name     = "AKS-RG-New1"   # 👈 existing RG name
  location = "Central India"

  lifecycle {
    prevent_destroy = true
  }
}

# ================================
# AZURE CONTAINER REGISTRY
# ================================
resource "azurerm_container_registry" "acr" {
  name                = "ghademoacr123"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Basic"
  admin_enabled       = true

  lifecycle {
    prevent_destroy = true
  }
}

# ================================
# AKS CLUSTER
# ================================
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-gha-demo"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aksghademo"

  default_node_pool {
    name       = "system"
    node_count = 1
    vm_size    = "Standard_DS2_v3"
  }

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    prevent_destroy = true
  }
}

