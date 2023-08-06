
provider "google" {
  project = var.project_id
  region  = var.region
}

resource "random_pet" "prefix" {}

resource "google_compute_network" "vpc" {
  name                    = "${var.project_id}-vpc"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_id}-subnet"
  region        = var.region
  network       = google_compute_network.vpc.name
  ip_cidr_range = "10.10.1.0/24"
}

resource "google_container_cluster" "primary" {
  name     = "my-gke-${random_pet.prefix.id}"
  location = var.location

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = google_container_cluster.primary.name
  location   = var.location
  cluster    = google_container_cluster.primary.name
  node_count = var.gke_num_nodes

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    machine_type = "n1-standard-1"
    disk_size_gb = 50
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
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
  service_account_id = "projects/${var.project_id}/serviceAccounts/${google_service_account.cluster_service_account.email}"
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[web/app-sa]",
  ]
}
