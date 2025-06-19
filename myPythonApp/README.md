# Kubernetes Deployment with Helm

---

## Project Structure

```
.
├── README.md
├── helmcharts
│   ├── helm_api
│   │   ├── Chart.yaml
│   │   ├── templates
│   │   └── values.yaml
│   └── helm_redis
│       ├── Chart.yaml
│       ├── templates
│       └── values.yaml
├── http
│   ├── http-client.env.json
│   └── sample_api.http
├── kustomization.yaml
└── sample_api
    ├── Dockerfile
    ├── __pycache__
    ├── config.yaml
    ├── docker-compose.yml
    ├── main.py
    └── requirements.txt
```

---

## Prerequisites

- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
- [kustomize](https://kubectl.docs.kubernetes.io/installation/kustomize/)
- [Helm](https://helm.sh/docs/intro/install/)

---

## 1. Build docker image for Sample API

```sh
docker build -t manerajona/sampleapi:v1 sample_api
```

## 2. Create a Namespace

Before deploying, create a namespace (e.g., `myns`) for your application resources (excluding the ingress controller):

```sh
kubectl create namespace myns
```

---

## 3. Deploy the nginx ingress with Kustomization file

Install the ingress-nginx controller in the `ingress-nginx` namespace

```sh
kubectl create namespace ingress-nginx
kustomize build . --enable-helm | kubectl apply -f -
```

---

## 4. Deploy Helm Charts (API and Redis)

### Deploy Redis

```sh
helm install my-redis helmcharts/helm_redis -n myns
```

### Deploy the API

```sh
helm install my-api helmcharts/helm_api -n myns
```