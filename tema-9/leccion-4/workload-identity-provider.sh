#!/bin/bash

# Obtener ID del proyecto
PROJECT_ID=$(gcloud config get-value project)

echo "Creating GitHub Actions service account..."
# Crear cuenta de servicio para GitHub
gcloud iam service-accounts create github-actions \
    --display-name "GitHub Actions service account"
echo "------------------------------------"

# Obtener la direccion de correos asociada a la cuenta de servicio
SERVICE_ACCOUNT_EMAIL=$(gcloud iam service-accounts list \
  --filter="displayName:GitHub Actions service account" \
  --format 'value(email)')

echo "Aassign roles to the GitHub service account..."
# Asignar roles a la cuenta de servicio de GitHub
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
  --member serviceAccount:${SERVICE_ACCOUNT_EMAIL} \
  --role roles/artifactregistry.admin
echo "------------------------------------"

echo "Creating a workload identity pool for GitHub..."
# Pool de Workload Identity para GitHub
gcloud iam workload-identity-pools create "github-wi-pool" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --display-name="GitHub pool"
echo "------------------------------------"

# Obtener el nombre del Workload Identity Pool
WORKLOAD_IDENTITY_POOL_NAME=$(gcloud iam workload-identity-pools list \
  --filter="displayName:GitHub pool" \
  --location="global" \
  --format 'value(name)')

echo "Creating a workload identity provider for GitHub..."
# Workload Identity Provider de GitHub
gcloud iam workload-identity-pools providers create-oidc "github-wi-provider" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --workload-identity-pool="github-wi-pool" \
  --display-name="GitHub provider" \
  --attribute-mapping="google.subject=assertion.repository,attribute.actor=assertion.actor,attribute.aud=assertion.aud" \
  --issuer-uri="https://token.actions.githubusercontent.com"
echo "------------------------------------"

echo "Impersonate workload identity with service account..."
# Permitir a la Cuenta de Servicio usar el Workload Identity
gcloud iam service-accounts add-iam-policy-binding ${SERVICE_ACCOUNT_EMAIL} \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/${WORKLOAD_IDENTITY_POOL_NAME}/*"