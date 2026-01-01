variable "subscription_id" {
  description = "c62d8ace-a447-4720-ae45-1e174ef20582"
  type        = string
}

variable "resource_gAKS-RGroup_name" {
  description = ""
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
