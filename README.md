
# 🐳 Kubernetes Multi-Tier Deployment: Flask API + PostgreSQL + GCP + DockerHub

## 🔗 Quick Links

- 📂 **Source Code Repository**: [GitHub Repo](https://github.com/RavishankarDuMCA10/Flask-Postgres-Docker-GCP)
- 🐋 **Docker Image**: [`ravishankarkushwaha13/flask_live_app:1.0.2`](https://hub.docker.com/repository/docker/ravishankarkushwaha13/flask_live_app)
- 🌐 **Live API Endpoint**: [`http://34.54.174.188/users`](http://34.54.174.188/users)

---

## 📘 Requirement Understanding

This project demonstrates a **Kubernetes-based multi-tier architecture** involving:

- A **Flask-based microservice (API tier)** that exposes RESTful endpoints.
- A **PostgreSQL database (DB tier)** that stores persistent user data.
- Full containerization and orchestration using **Docker** and **Kubernetes**.

---

## 🧠 Assumptions

- PostgreSQL uses default user (`postgres`) and database (`postgres`).
- Connection parameters (host, user, port) are injected via ConfigMap.
- Passwords are stored securely using Kubernetes Secrets.
- Application is externally accessible via an Ingress controller.

---

## 🛠️ Solution Overview

### Architecture

```
                ┌────────────────────────────┐
                │     Ingress Controller     │
                │   (Exposes /users API)     │
                └────────────┬───────────────┘
                             │
                 ┌───────────▼────────────┐
                 │      Flask API         │
                 │  (4 Pods, LoadBalanced)│
                 └───────────┬────────────┘
                             │
                      ┌──────▼───────┐
                      │ PostgreSQL DB│
                      │ (1 Pod + PVC)│
                      └──────────────┘
```

### Tech Stack

- **Backend**: Python 3, Flask, psycopg2
- **Database**: PostgreSQL 12
- **Containerization**: Docker
- **Orchestration**: Kubernetes (with Ingress, ConfigMaps, Secrets, PVC)

---

## 🧱 Kubernetes Resources

| Component            | Kind              | File                          |
|---------------------|-------------------|-------------------------------|
| Flask Deployment     | `Deployment`      | `flask-app-deployment.yaml`   |
| Flask Service        | `Service`         | `flask-app-service.yaml`      |
| DB Deployment        | `Deployment`      | `flask-db-deployment.yaml`    |
| DB Service           | `Service`         | `flask-db-service.yaml`       |
| Ingress              | `Ingress`         | `ingress.yaml`                |
| ConfigMap            | `ConfigMap`       | `configmap.yaml`              |
| Secret               | `Secret`          | `flask-secrets.yaml`          |
| Persistent Volume    | `PersistentVolume`| `pv.yaml`                     |
| PersistentVolumeClaim| `PVC`             | `postgres-pvc.yaml`           |

---

## ⚙️ Deployment Steps

1. **Apply Kubernetes objects**

```bash
kubectl apply -f configmap.yaml
kubectl apply -f flask-secrets.yaml
kubectl apply -f pv.yaml
kubectl apply -f postgres-pvc.yaml
kubectl apply -f flask-db-deployment.yaml
kubectl apply -f flask-db-service.yaml
kubectl apply -f flask-app-deployment.yaml
kubectl apply -f flask-app-service.yaml
kubectl apply -f ingress.yaml
```

2. **Verify Deployments and Services**

```bash
kubectl get pods
kubectl get svc
kubectl get ingress
```

3. **Create User via API**

```bash
kubectl exec -it <flask-pod-name> -- /bin/sh
apk add --no-cache curl
curl -X POST http://34.54.174.188/users   -H "Content-Type: application/json"   -d '{"username": "Alice", "email": "alice@example.com"}'
```

---

## 🔒 Config & Secrets Management

- **ConfigMap** (`flask-config`) sets DB connection params (host, port, name, user).
- **Secret** (`flask-secrets`) secures `POSTGRES_PASSWORD` using base64-encoded value.

---

## 💾 Data Persistence

- PVC ensures PostgreSQL data persists even if the pod is recreated.
- PV is manually defined with `hostPath` for persistent disk simulation on minikube/GKE.

---

## 🔁 Rolling Updates & Resilience

- API tier uses `replicas: 4` and supports rolling updates.
- Database has `replicas: 1` and uses a persistent volume to retain data on restarts.

---

## ❌ Pod Failure Simulation

### Flask API Pod

```bash
kubectl delete pod <flask-app-pod>
```
➡️ New pod is automatically recreated due to Deployment controller.

### PostgreSQL DB Pod

```bash
kubectl delete pod <flask-db-pod>
```
➡️ Pod restarts with persistent data intact thanks to PVC.

---

## 💡 Justification for Resource Choices

| Component        | Justification                                               |
|------------------|-------------------------------------------------------------|
| **4 API Pods**   | Ensures high availability and load balancing.              |
| **1 DB Pod**     | Single DB instance sufficient; stateful with PVC.          |
| **PVC + PV**     | Data persistence across pod terminations.                  |
| **Ingress**      | Clean external exposure with URL routing.                  |
| **Secrets**      | Keeps credentials secure and out of version control.       |
| **ConfigMap**    | Externalizes DB config without hardcoding in app.          |

---

## 📦 Docker Image Details

**Flask API Image**:  
[`ravishankarkushwaha13/flask_live_app:1.0.2`](https://hub.docker.com/repository/docker/ravishankarkushwaha13/flask_live_app)  
Contains `Flask`, `psycopg2`, and `app.py` to connect with PostgreSQL.

---

## 🧪 API Endpoints

| Method | Endpoint             | Description              |
|--------|----------------------|--------------------------|
| `GET`  | `/users`             | Fetch all users          |
| `POST` | `/users`             | Add a new user           |

---
## 🐋 Docker Build & Push Instructions

To build and push the Docker image for the Flask API to Docker Hub, use the following command:

```bash
docker buildx build --platform linux/amd64 -t ravishankarkushwaha13/flask_live_app:1.0.1 --push .
```
