#!/bin/bash

# Obtener ID del proyecto host
FLEET_HOST_PROJECT_ID=$(gcloud config get-value project)

# Crear cuenta de servicio
gcloud iam service-accounts create terraform \
    --display-name "Terraform service account"

# Obtener la direccion de correos asociada a la cuenta de servicio
SERVICE_ACCOUNT_EMAIL=$(gcloud iam service-accounts list \
  --filter="displayName:Terraform service account" \
  --format 'value(email)')

# Asignar roles
gcloud projects add-iam-policy-binding ${FLEET_HOST_PROJECT_ID} \
   --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
   --role="roles/gkehub.admin"
gcloud projects add-iam-policy-binding ${FLEET_HOST_PROJECT_ID} \
   --member="serviceAccount:$SERVICE_ACCOUNT_EMAIL" \
   --role="roles/container.admin"

# Crear y exportar key de la cuenta de servicio
gcloud iam service-accounts keys create terraform.json \
    --iam-account $SERVICE_ACCOUNT_EMAIL