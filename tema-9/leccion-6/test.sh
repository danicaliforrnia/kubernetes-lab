#!/bin/bash

echo '------- test from frontend -------'
kubectl exec -it web -n frontend -- curl api.backend --connect-timeout 5

echo '------- test from backend -------'
kubectl exec -it api -n backend -- curl web.frontend --connect-timeout 5