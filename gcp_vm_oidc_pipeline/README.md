# GCP VM Deployment via Terraform using Azure DevOps OIDC

## 🎯 Goal

Deploy a GCP VM using Terraform via Azure DevOps with OIDC-based federated identity authentication.

## 🔐 Prerequisites

- GCP Project & Billing Enabled
- GCS Bucket for Remote State
- Service Account with `roles/compute.admin` and `roles/iam.serviceAccountUser`
- Workload Identity Federation (OIDC provider) setup in GCP
- Federation binding from Azure DevOps

## 📁 Files Included

- `terraform/` - Terraform configuration for GCP VM
- `azure-pipelines.yml` - Azure DevOps pipeline using OIDC
- `README.md` - This documentation

## 🧭 Pipeline Steps

1. Azure DevOps creates `oidc-creds.json` using pipeline-scoped variables
2. Terraform uses this credential to authenticate via WIF
3. A VM is created in GCP in the specified region and zone

## 🛠️ Usage

- Replace `your-project-id`, `your-gcs-bucket`, and other placeholder values
- Commit to your repo with `main` branch
- Create a variable group in Azure DevOps for any secret values

## ✅ Result

A Debian VM will be deployed in GCP via Terraform, using secure OIDC-based credentials from Azure DevOps.
