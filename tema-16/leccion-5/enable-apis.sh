#!/bin/bash

# Obtener ID del proyecto host
FLEET_HOST_PROJECT_ID=$(gcloud config get-value project)

# Habilitar APIs
gcloud services enable \
   --project=${FLEET_HOST_PROJECT_ID} \
   container.googleapis.com \
   gkeconnect.googleapis.com \
   gkehub.googleapis.com \
   cloudresourcemanager.googleapis.com \
   iam.googleapis.com