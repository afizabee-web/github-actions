output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "acr_username" {
  value = azurerm_container_registry.acr.admin_username
  sensitive = true
}

output "acr_password" {
  value = azurerm_container_registry.acr.admin_password
  sensitive = true
}
 
output "kube_config" {
    value = azurerm_kubernetes_cluster.aks.kube_config_raw
    sensitive = true
}
