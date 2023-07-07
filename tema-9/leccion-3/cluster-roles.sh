#!/bin/bash

kubectl create clusterrole demo-cluster-role --verb=* --resource=pods
kubectl create clusterrolebinding demo-cluster-role-binding --clusterrole=demo-cluster-role --user=user1