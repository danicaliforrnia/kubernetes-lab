provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_storage_project_service_account" "gcs_account" {
}

resource "google_project_iam_member" "default" {
  project = var.project_id
  role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member  = "serviceAccount:${data.google_storage_project_service_account.gcs_account.email_address}"
}

resource "google_kms_key_ring" "terraform_state" {
  name     = "${random_id.bucket_prefix.hex}-bucket-tfstate"
  location = var.region
}

resource "google_kms_crypto_key" "terraform_state_bucket" {
  name            = "test-terraform-state-bucket"
  key_ring        = google_kms_key_ring.terraform_state.id
  rotation_period = "86400s"

  lifecycle {
    prevent_destroy = false
  }
}

resource "random_id" "bucket_prefix" {
  byte_length = 8
}

resource "google_storage_bucket" "default" {
  name          = "${random_id.bucket_prefix.hex}-bucket-tfstate"
  location      = var.region
  force_destroy = false
  storage_class = "STANDARD"

  versioning {
    enabled = true
  }

  encryption {
    default_kms_key_name = google_kms_crypto_key.terraform_state_bucket.id
  }

  depends_on = [
    google_project_iam_member.default
  ]
}