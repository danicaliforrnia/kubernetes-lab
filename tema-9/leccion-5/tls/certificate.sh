#!/bin/bash

# Crear llave privada
openssl genrsa -out certs/helloapp.key 2048

# Crear CSR: Client Signing Request
openssl req -new \
	-key certs/helloapp.key \
	-out certs/helloapp.csr \
	-subj "/CN=curso-k8s.ddns.net"

# Crear Certificado auto firmado
openssl x509 -req \
  -in certs/helloapp.csr \
  -signkey certs/helloapp.key \
  -out certs/helloapp.crt -days 365 

# Crear Secret de Kubernetes
kubectl create secret tls hello-app-tls \
--key certs/helloapp.key \
--cert certs/helloapp.crt