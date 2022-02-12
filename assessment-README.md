# k3d install
wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

## create cluster
k3d cluster create sandman \
            -p 8080:80@loadbalancer \
            -v /etc/machine-id:/etc/machine-id:ro \
            -v /var/log/journal:/var/log/journal:ro \
            -v /var/run/docker.sock:/var/run/docker.sock \
           --k3s-arg "--disable=traefik@server:0" \
            --agents 0

## Delete cluster
k3d cluster delete sandman 

# Installing ingress

helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx --create-namespace


# prometheus

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install my-release prometheus-community/prometheus

# From the repository root
kubectl apply -f kubernetes -R
