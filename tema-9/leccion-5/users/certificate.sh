#!/bin/bash

# Crear llave privada
openssl genrsa -out certs/demouser.key 2048

# Crear CSR: Certificate Signing Request
openssl req -new \
	-key certs/demouser.key \
	-out certs/demouser.csr \
	-subj "/CN=demouser/"

# Crear Certificado - Opción 1
openssl x509 \
	-req -in certs/demouser.csr \
	-CA ~/.minikube/ca.crt \
	-CAkey ~/.minikube/ca.key \
	-CAcreateserial -out certs/demouser.crt \
	-days 365

# Crear Certificado - Opción 2
cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: demouser-csr
spec:
  request: $(cat certs/demouser.csr | base64 | tr -d '\n')
  signerName: kubernetes.io/kube-apiserver-client
  groups:
    - 'system:authenticated'
  usages:
    - client auth
EOF