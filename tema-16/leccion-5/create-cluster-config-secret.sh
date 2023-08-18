#!/bin/bash

istioctl x create-remote-secret \
    --context=$CTX_CLUSTER1 \
    --name=cluster-1 | \
    kubectl apply -f - --context=$CTX_CLUSTER2

istioctl x create-remote-secret \
    --context=$CTX_CLUSTER2 \
    --name=cluster-2 | \
    kubectl apply -f - --context=$CTX_CLUSTER1