# /bin/bash


# Exponer el Pod de frontend
kubectl expose pod web --type=ClusterIP --port=80 -n frontend

# Exponer el Pod de backend
kubectl expose pod api --type=ClusterIP --port=80 -n backend

# Exponer el Pod de test
kubectl expose pod test --type=ClusterIP --port=80 -n test