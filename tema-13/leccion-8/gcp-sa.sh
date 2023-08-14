#!/bin/bash

# Obtener ID del proyecto
PROJECT_ID=$(gcloud config get-value project)

# Crear cuenta de servicio para velero
gcloud iam service-accounts create velero \
    --display-name "Velero service account"

# Obtener la direccion de correos asociada a la cuenta de servicio
SERVICE_ACCOUNT_EMAIL=$(gcloud iam service-accounts list \
  --filter="displayName:Velero service account" \
  --format 'value(email)')

# Definir los permisos necesarios
ROLE_PERMISSIONS=(
    compute.disks.get
    compute.disks.create
    compute.disks.createSnapshot
    compute.projects.get
    compute.snapshots.get
    compute.snapshots.create
    compute.snapshots.useReadOnly
    compute.snapshots.delete
    compute.zones.get
    storage.objects.create
    storage.objects.delete
    storage.objects.get
    storage.objects.list
    iam.serviceAccounts.signBlob
)

# Crear un rol velero.server con los permisos definidos
gcloud iam roles create velero.server \
    --project $PROJECT_ID \
    --title "Velero Server" \
    --permissions "$(IFS=","; echo "${ROLE_PERMISSIONS[*]}")"    

# Asignar rol a la cuenta de servicio
gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member serviceAccount:$SERVICE_ACCOUNT_EMAIL \
    --role projects/$PROJECT_ID/roles/velero.server

# Otorgar permisos sobre el bucket
gsutil iam ch serviceAccount:$SERVICE_ACCOUNT_EMAIL:objectAdmin gs://${BUCKET}

# Crear y exportar key de la cuenta de servicio
gcloud iam service-accounts keys create credentials-velero.json \
    --iam-account $SERVICE_ACCOUNT_EMAIL