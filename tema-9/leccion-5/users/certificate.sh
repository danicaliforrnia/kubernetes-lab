#!/bin/bash

# Crear llave privada
openssl genrsa -out certs/demouser.key 2048

# Crear CSR: Certificate Signing Request
openssl req -new \
	-key certs/demouser.key \
	-out certs/demouser.csr \
	-subj "/CN=demouser/"

# Crear Certificado
openssl x509 \
	-req -in certs/demouser.csr \
	-CA ~/.minikube/ca.crt \
	-CAkey ~/.minikube/ca.key \
	-CAcreateserial -out certs/demouser.crt \
	-days 365