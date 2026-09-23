variable "project_name" {
  description = "Short name used as a prefix for all resources"
  type        = string
  default     = "proj4aks"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region to deploy into"
  type        = string
  default     = "westeurope"
}

variable "vnet_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "aks_subnet_address_prefix" {
  description = "Address prefix for the AKS node subnet"
  type        = list(string)
  default     = ["10.10.1.0/24"]
}

variable "kubernetes_version" {
  description = "Kubernetes version for the AKS cluster"
  type        = string
  default     = "1.30"
}

variable "node_vm_size" {
  description = "VM size for the default node pool (kept small for cost control)"
  type        = string
  default     = "Standard_B2s"
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 1
}

variable "aks_service_account_namespace" {
  description = "Kubernetes namespace where the app's service account will run"
  type        = string
  default     = "default"
}

variable "aks_service_account_name" {
  description = "Kubernetes service account name used for workload identity federation"
  type        = string
  default     = "myapp-sa"
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    project     = "project4-aks-platform"
    managed_by  = "terraform"
  }
}