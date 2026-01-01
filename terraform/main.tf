terraform {
  required_version = ">= 1.4.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }
}

provider "azurerm" {
  features {}
}

# ---------------------------
# EXISTING RESOURCE GROUP
# ---------------------------
data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# ---------------------------
# EXISTING ACR
# ---------------------------
data "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

# ---------------------------
# AKS CLUSTER
# ---------------------------
resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = var.aks_name

  default_node_pool {
    name       = "nodepool1"
    node_count = var.node_count
    vm_size    = var.node_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    environment = "dev"
    managed_by  = "terraform"
  }
}

# ---------------------------
# ALLOW AKS TO PULL FROM ACR
# ---------------------------
resource "azurerm_role_assignment" "aks_acr_pull" {
  depends_on = [
    azurerm_kubernetes_cluster.aks
  ]

  scope                = data.azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}


