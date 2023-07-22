#!/bin/bash

kubetest2 gke -v 2 \
  --up \
  --project cursos-imagina \
  --cluster-name e2e-test \
  --zone europe-west3-a \
  --num-nodes 2 \
  --ignore-gcp-ssh-key \
  --down \
  --test=exec -- ./e2e-tests.sh