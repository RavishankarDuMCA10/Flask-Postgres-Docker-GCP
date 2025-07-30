# Multi-Tier Kubernetes Deployment: Flask API + PostgreSQL DB

## 🔗 Project Links

- **Code Repository:** [GitHub Repo](https://github.com/RavishankarDuMCA10/Flask-Postgres-Docker-GCP)
- **Docker Image:** [Docker Hub](https://hub.docker.com/r/ravishankarkushwaha13/flask_live_app)

> Replace the URL above with your actual Ingress IP or domain.

---

## 📦 Tech Stack

- Flask (Python) for Microservice
- PostgreSQL as the Database
- Docker for Containerization
- Kubernetes for Deployment
- GCP (GKE) as Cloud Platform

---

## 🧾 Features

| Tier            | Feature                                  | Support |
|-----------------|------------------------------------------|---------|
| API (Flask)     | Exposed via Ingress                      | ✅      |
|                 | 4 pods with rolling update support       | ✅      |
|                 | Fetches data from DB via API             | ✅      |
| Database (Postgres) | 1 pod with persistent volume         | ✅      |
|                 | 5–10 sample records                      | ✅      |
| Security        | ConfigMap + Secret for DB config         | ✅      |

---

## 🗃 Kubernetes Objects

| Object       | Description               |
|--------------|---------------------------|
| ConfigMap    | DB host/user/name info     |
| Secret       | DB password                |
| Deployment   | Flask app (4 pods)         |
| Deployment   | PostgreSQL DB (1 pod)      |
| PVC          | DB data volume claim       |
| PV           | DB data persistent volume  |
| Service      | ClusterIP for app + db     |
| Ingress      | External access to API     |

---

## 🧪 How to Test

1. Access API endpoint:

