#!/bin/bash

# Crear llave privada
openssl genrsa -out certs/demouser.key 2048

# Crear CSR: Client Signing Request
openssl req -new \
	-key certs/demouser.key \
	-out certs/demouser.csr \
	-sbj "/CN=demouser/0=group1"

# Crear Certificado
openssl x509 \
	-req -in certs/demouser.csr \
	-CA ~/.minikube/ca.crt \
	-CAkey ~/.minikube/ca.key \
	-CAcreateserial -out certs/demouser.crt \
	-days 365