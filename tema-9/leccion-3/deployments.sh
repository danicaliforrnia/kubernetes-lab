#!/bin/bash

kubectl create deployment nginx --image=nginx --namespace n1
kubectl create deployment nginx --image=nginx --namespace n2