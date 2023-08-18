#!/bin/bash

CTX_CLUSTER1=cluster-1
for i in $(seq 10); do kubectl exec --context=$CTX_CLUSTER1 -n sample -c sleep \
    "$(kubectl get pod --context=$CTX_CLUSTER1 -n sample -l \
    app=sleep -o jsonpath='{.items[0].metadata.name}')" \
    -- curl -sS helloworld.sample:5000/hello; done
