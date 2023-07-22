#!/bin/bash

kubetest2 gke -v 2 \
  --up --cluster-name conformance-test \
  --project cursos-imagina \
  --zone europe-west1-b \
  --num-nodes 2 \
  --ignore-gcp-ssh-key \
  --down \
  --test ginkgo \
  -- \
  --focus-regex='\[Conformance\]'