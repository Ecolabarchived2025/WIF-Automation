resource "google_service_account" "azuredevops_sa" {
  account_id   = var.sa_name
  display_name = "Azure DevOps Workload Identity SA"
}

resource "google_iam_workload_identity_pool" "azuredevops_pool" {
  workload_identity_pool_id = var.pool_id
  display_name              = "Azure DevOps Pool"
  description               = "OIDC pool for Azure DevOps"
}

resource "google_iam_workload_identity_pool_provider" "azuredevops_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.azuredevops_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = var.provider_id
  display_name                       = "Azure DevOps Provider"
  description                        = "Federated identity provider for Azure DevOps"

  oidc {
    issuer_uri = var.azure_oidc_issuer
  }

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }

  attribute_condition = <<EOT
    assertion.repository == "${var.azure_repo}"
  EOT
}

resource "google_service_account_iam_member" "allow_impersonation" {
  service_account_id = google_service_account.azuredevops_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.azuredevops_pool.name}/attribute.repository/${var.azure_repo}"
}