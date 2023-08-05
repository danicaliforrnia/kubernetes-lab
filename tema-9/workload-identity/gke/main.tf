
provider "google" {
  project = var.project_id
  region  = var.region
}

resource "random_pet" "prefix" {}

resource "google_container_cluster" "primary" {
  name     = "my-gke-${random_pet.prefix.id}"
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  workload_identity_config {
    identity_namespace = "${var.project_id}.svc.id.goog"
  }
}

resource "google_service_account" "cluster_service_account" {
  project      = var.project_id
  account_id   = "app-sa"
  display_name = "GCP SA bound to k8s SA"
}

resource "google_project_iam_member" "storage_bucket" {
  project = var.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.cluster_service_account.email}"
}

resource "google_service_account_iam_binding" "sa_binding" {
  project            = var.project_id
  service_account_id = google_service_account.cluster_service_account.email
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[web/app-sa]",
  ]
}
