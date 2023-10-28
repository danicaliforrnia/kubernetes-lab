#!/bin/sh

SUBSCRIPTION_ID="2a39ffe8-6bc5-48af-8ff9-f467f95c80b7"
RESOURCE_GROUP_NAME="eks-imagina-demo"
AKS_NAME="demo-01"
LOCATION="westeurope"
NODE_SIZE="Standard_B2s"
DEPLOYMENT_NAME=$AKS_NAME-$RANDOM
DNS_PREFIX=$AKS_NAME-$LOCATION-$RANDOM

az account set --subscription $SUBSCRIPTION_ID
az group create --name $RESOURCE_GROUP_NAME --location "$LOCATION"