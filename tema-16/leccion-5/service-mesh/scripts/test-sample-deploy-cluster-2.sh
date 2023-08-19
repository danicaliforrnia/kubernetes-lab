#!/bin/bash

CTX_CLUSTER2=cluster2
for i in $(seq 10); do kubectl exec --context=$CTX_CLUSTER2 -n sample -c sleep \
    "$(kubectl get pod --context=$CTX_CLUSTER2 -n sample -l \
    app=sleep -o jsonpath='{.items[0].metadata.name}')" \
    -- curl -sS helloworld.sample:5000/hello; done