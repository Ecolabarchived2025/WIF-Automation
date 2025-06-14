variable "project_id" {}
variable "region" {
  default = "us-central1"
}

variable "pool_id" {
  default = "azuredevops-pool"
}

variable "provider_id" {
  default = "azuredevops-provider"
}

variable "sa_name" {
  default = "azuredevops-sa"
}

variable "azure_repo" {
  description = "Azure DevOps repo URL for audience match"
}

variable "azure_oidc_issuer" {
  default = "https://vstoken.actions.githubusercontent.com"
  description = "OIDC issuer URL for Azure DevOps"
}