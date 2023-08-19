provider "google-beta" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "gke_a" {
  provider = google-beta
  name     = "${var.cluster_name}-${var.env_name}-a"
  location = var.zone
  initial_node_count = 1
  
  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  node_config {
    machine_type = "e2-standard-4"
    disk_size_gb = 50
  }
}

resource "google_container_cluster" "gke_b" {
  provider           = google-beta
  name               = "${var.cluster_name}-${var.env_name}-b"
  location           = var.zone
  initial_node_count = 1

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  node_config {
    machine_type = "e2-standard-4"
    disk_size_gb = 50
  }
}

resource "google_gke_hub_membership" "gke_membership_a" {
  provider      = google-beta
  membership_id = "${var.membership_prefix}--${var.env_name}-a"

  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${google_container_cluster.gke_a.id}"
    }
  }

  authority {
    issuer = "https://container.googleapis.com/v1/${google_container_cluster.gke_a.id}"
  }
}

resource "google_gke_hub_membership" "gke_membership_b" {
  provider      = google-beta
  membership_id = "${var.membership_prefix}--${var.env_name}-b"

  endpoint {
    gke_cluster {
      resource_link = "//container.googleapis.com/${google_container_cluster.gke_b.id}"
    }
  }

  authority {
    issuer = "https://container.googleapis.com/v1/${google_container_cluster.gke_b.id}"
  }
}