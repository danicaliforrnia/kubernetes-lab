#!/bin/bash

minikube ssh -n minikube 'sudo mv /etc/kubernetes/manifests /etc/kubernetes/manifests.error'
