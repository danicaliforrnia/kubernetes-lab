terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.47.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_service_account" "service_account" {
  project    = var.project_id
  account_id = "gke-service-account"
}

resource "google_project_iam_member" "service_account-roles" {
  for_each = toset([
    "roles/iam.serviceAccountTokenCreator",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountUser",
    "roles/compute.admin",
    "roles/storage.admin",
    "roles/container.admin",
    "roles/container.clusterViewer",
    "roles/resourcemanager.projectIamAdmin",
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer"
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.service_account.email}"
}