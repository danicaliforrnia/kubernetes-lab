#!/bin/bash

minikube ssh -n minikube-m02 'sudo mv /var/lib/kubelet/config.yaml /var/lib/kubelet/config.yml && sudo systemctl restart kubelet'
