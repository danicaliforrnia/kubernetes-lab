#!/bin/bash

kubectl create role demo-role --verb=* --resource=deployments --namespace n1
kubectl create rolebinding demo-role-binding --role=demo-role --user=user1 -n n1