# GCP Workload Identity Federation for Azure DevOps

This Terraform module sets up **Workload Identity Federation (WIF)** in Google Cloud to allow **Azure DevOps pipelines** to authenticate and impersonate a Google Cloud Service Account — without needing service account keys.

---

## 🔧 What This Terraform Project Does

- Creates a **Google Service Account** (SA)
- Creates a **Workload Identity Pool**
- Creates a **Workload Identity Provider** for Azure DevOps
- Binds the SA to the WIF provider with impersonation rights (`roles/iam.workloadIdentityUser`)

---

## 📁 File Structure

```
gcp-workload-identity/
├── main.tf                  # WIF + SA + IAM bindings
├── variables.tf             # Configurable inputs
├── outputs.tf               # Output values for DevOps setup
├── terraform.tfvars         # Sample inputs (edit before use)
└── provider.tf              # Google Cloud provider block
```

---

## ✅ Prerequisites

- A GCP project with billing enabled
- Terraform CLI installed (`>= 1.0`)
- Admin IAM permissions in GCP

---

## 🔗 Inputs (`terraform.tfvars`)

Update this file with your GCP and Azure DevOps details:

```hcl
project_id   = "your-gcp-project-id"
region       = "us-central1"
azure_repo   = "your-org/your-repo" # Azure DevOps repo in 'org/project' format
```

---

## 🚀 Usage

```bash
terraform init
terraform apply
```

---

## 📤 Outputs

After apply, Terraform will show:

- `service_account_email`: Use this in Azure DevOps Service Connection
- `workload_identity_provider_name`: Required for Azure DevOps setup

---

## 🔐 Azure DevOps Configuration

1. Go to **Azure DevOps → Project Settings → Service Connections**
2. Click **New service connection → Google Cloud**
3. Choose **Workload Identity Federation**
4. Fill in:
   - **GCP Project ID**: same as `project_id`
   - **Workload Identity Pool ID**: from output
   - **Provider ID**: from output
   - **Service Account Email**: from output
5. Save and verify

---

## 🧱 What To Do Next

Now that WIF is configured:
- Use this connection in your Azure DevOps Terraform pipeline.
- Example: impersonate the `service_account_email` in your `main.tf`.

```hcl
provider "google" {
  project     = var.project_id
  region      = var.region
  impersonate_service_account = "<service_account_email_from_output>"
}
```

---

## 📄 License

MIT License