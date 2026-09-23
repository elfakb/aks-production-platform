
# AKS Platform – Terraform

Infrastructure-as-Code project that provisions a production-ready Kubernetes (AKS) platform on Azure using Terraform. Includes Workload Identity, Key Vault (RBAC) integration, and a Container Registry.

## Architecture / Resources Created

- **Resource Group** – Container for all resources
- **Virtual Network & Subnet** – Dedicated network for AKS
- **AKS (Azure Kubernetes Service)** – Managed Kubernetes cluster (with Workload Identity and OIDC Issuer enabled)
- **Azure Container Registry (ACR)** – Registry for Docker images
- **Key Vault (RBAC-authorized)** – Secure storage for secrets
- **User Assigned Identities** – Separate managed identities for the AKS control plane and workload identity
- **Federated Identity Credential** – Allows pods to access Azure resources (like Key Vault) via their Kubernetes Service Account, without credentials (Workload Identity)
- **Role Assignments** – ACR Pull, Key Vault Administrator, Key Vault Secrets User

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.x
- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli)
- An active Azure subscription

## Getting Started

1. Log in to Azure:
```bash
   az login
```

2. Edit `terraform.tfvars` to match your environment (region, naming, Kubernetes version, etc.)

3. Initialize Terraform:
```bash
   terraform init
```

4. Preview the plan:
```bash
   terraform plan
```

5. Apply the configuration:
```bash
   terraform apply
```

6. Connect to the AKS cluster:
```bash
   az aks get-credentials --resource-group <resource_group_name> --name <aks_cluster_name>
   kubectl get nodes
```

## Cleanup

To destroy all resources:
```bash
terraform destroy
```


# AKS Platform – Terraform

Terraform ile Azure üzerinde production-ready bir Kubernetes (AKS) platformu kuran altyapı-kodu (IaC) projesi. Workload Identity, Key Vault (RBAC) entegrasyonu ve Container Registry içerir.

## Mimari / Oluşturulan Kaynaklar

- **Resource Group** – Tüm kaynakların toplandığı grup
- **Virtual Network & Subnet** – AKS için özel ağ altyapısı
- **AKS (Azure Kubernetes Service)** – Managed Kubernetes cluster (Workload Identity ve OIDC Issuer etkin)
- **Azure Container Registry (ACR)** – Docker image'larının saklandığı registry
- **Key Vault (RBAC yetkilendirmeli)** – Secret'ların güvenli şekilde saklandığı yer
- **User Assigned Identities** – AKS control plane ve workload identity için ayrı managed identity'ler
- **Federated Identity Credential** – Pod'ların Kubernetes Service Account üzerinden Azure kaynaklarına (Key Vault gibi) parola gerekmeden erişmesini sağlar (Workload Identity)
- **Role Assignments** – ACR Pull, Key Vault Administrator, Key Vault Secrets User

## Gereksinimler

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.x
- [Azure CLI](https://learn.microsoft.com/cli/azure/install-azure-cli)
- Aktif bir Azure subscription

## Kurulum

1. Azure'a giriş yap:
```bash
   az login
```

2. `terraform.tfvars` dosyasını kendi ortamına göre düzenle (bölge, isimler, Kubernetes versiyonu vb.)

3. Terraform'u başlat:
```bash
   terraform init
```

4. Planı önizle:
```bash
   terraform plan
```

5. Kaynakları oluştur:
```bash
   terraform apply
```

6. AKS cluster'a bağlan:
```bash
   az aks get-credentials --resource-group <resource_group_name> --name <aks_cluster_name>
   kubectl get nodes
```

## Temizlik

Tüm kaynakları silmek için:
```bash
terraform destroy
```
