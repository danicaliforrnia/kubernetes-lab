#!/bin/bash

# Crear llave privada
openssl genrsa -out certs/ca.key 2048

# Crear CSR: Client Signing Request
openssl req -new \
	-key certs/helloapp.key \
	-out certs/helloapp.csr \
	-sbj "/CN=curso-k8s.ddns.net"

# Crear Certificado auto firmado
openssl x509 -req \
  -in helloapp.csr \
  -signkey helloapp.key \
  -out helloapp.crt -days 365 

# Crear Secret de Kubernetes
kubectl create secret tls hello-app-tls \
--key ca.key \
--cert ca.crt