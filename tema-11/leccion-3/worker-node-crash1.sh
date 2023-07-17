#!/bin/bash

minikube ssh -n minikube-m02 'sudo systemctl disable kubelet.service && sudo systemctl stop kubelet.service'
