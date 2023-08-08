#!/bin/bash

# Crear llave privada
openssl genrsa -out certs/demouser-2.key 2048

# Crear CSR: Certificate Signing Request
openssl req -new \
	-key certs/demouser-2.key \
	-out certs/demouser-2.csr \
	-subj "/CN=demouser/"

# Crear objeto CertificateSigningRequest
cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: demouser-csr
spec:
  request: $(cat certs/demouser-2.csr | base64 | tr -d '\n')
  signerName: kubernetes.io/kube-apiserver-client
  groups:
    - 'system:authenticated'
  usages:
    - client auth
EOF