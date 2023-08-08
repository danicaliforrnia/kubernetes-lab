#!/bin/bash

kubectl config set-credentials demouser --client-certificate=certs/demouser.crt --client-key=certs/demouser.key
kubectl config set-context demouser --cluster=minikube --user=demouser