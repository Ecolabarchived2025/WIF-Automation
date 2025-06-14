output "service_account_email" {
  value = google_service_account.azuredevops_sa.email
}

output "workload_identity_provider_name" {
  value = google_iam_workload_identity_pool_provider.azuredevops_provider.name
}