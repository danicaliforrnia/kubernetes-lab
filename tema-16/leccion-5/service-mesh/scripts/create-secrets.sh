#!/bin/bash

kubectl create namespace istio-system --context=$CTX_CLUSTER1
kubectl create secret generic cacerts -n istio-system \
      --from-file=../certs/cluster1/ca-cert.pem \
      --from-file=../certs/cluster1/ca-key.pem \
      --from-file=../certs/cluster1/root-cert.pem \
      --from-file=../certs/cluster1/cert-chain.pem

kubectl create namespace istio-system --context=$CTX_CLUSTER2
kubectl create secret generic cacerts -n istio-system \
      --from-file=../certs/cluster2/ca-cert.pem \
      --from-file=../certs/cluster2/ca-key.pem \
      --from-file=../certs/cluster2/root-cert.pem \
      --from-file=../certs/cluster2/cert-chain.pem