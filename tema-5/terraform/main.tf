provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_service_account" "github" {
  account_id = "github-docker-push"
}

resource "google_project_iam_member" "github_token_creator" {
  project = var.project_id
  role    = "roles/iam.serviceAccountTokenCreator"
  member  = "serviceAccount:${google_service_account.github.email}"
}

resource "google_project_iam_member" "github_act_as" {
  project = var.project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.github.email}"
}

resource "google_artifact_registry_repository" "imagina_k8s" {
  location      = var.region
  repository_id = "imagina-k8s"
  format        = "DOCKER"
}