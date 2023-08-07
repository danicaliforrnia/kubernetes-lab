#!/bin/bash

# Obtener certificado
kubectl get csr demouser-csr \
	-o jsonpath='{.status.certificate}' \
    | base64 --decode > certs/demouser-2.crt