variable "resource_group_name" {
  description = "AKS-RG"
  type        = string
}

variable "acr_name" {
  description = "acr1123"
  type        = string
}

variable "aks_name" {
  description = "tf-cluster"
  type        = string
}

variable "node_count" {
  description = "1"
  type        = number
  default     = 2
}

variable "node_vm_size" {
  description = "Standard_D4ds_v5"
  type        = string
  default     = "Standard_DS2_v2"
}
