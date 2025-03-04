TerraFlaskQLK8s 🐶 – Your Daily Beagle Treat!
TerraFlaskQLK8s is an automated, containerized deployment solution for a Flask application. It leverages GitHub Actions for CI/CD, Docker for containerization, Terraform and Helm for provisioning and deployment on Google Kubernetes Engine (GKE), and Prometheus/Grafana for monitoring.

Key Features
CI/CD Pipeline: Automated build, test, and deployment via GitHub Actions.
Containerization: Dockerized app ensuring consistency across environments.
Infrastructure as Code: Terraform provisions the GKE cluster while Helm manages Kubernetes deployments.
Monitoring & Security: Prometheus and Grafana monitor performance and trigger alerts. dockerignore and gitignore keep info safe.
Quick Start
Clone the Repository:
bash
Copy
git clone https://github.com/YourUsername/terraflaskqlk8s.git
cd terraflaskqlk8s
Install Dependencies:
bash
Copy
pip install -r requirements.txt
Run Locally:
bash
Copy
flask run
Access the app at http://127.0.0.1:5000
Test with Docker Compose:
bash
Copy
docker compose up --build
curl http://localhost:5000
CI/CD Workflow Overview
Build Stage:
A Docker image is built from the source code and pushed to Docker Hub.
Test Stage:
Docker Compose creates a multi-container setup to run integration tests.
Helm Stage:
The Helm chart is updated (using a version from CI), packaged, and pushed.
Deployment Stage:
Terraform provisions the GKE cluster and Helm deploys the updated application.
Monitoring:
Prometheus and Grafana ensure the app is performing as expected.
Prerequisites
Python 3.8+
Docker & Docker Compose
GitHub Actions enabled
Terraform
Helm
Configuration
Set up necessary secrets (e.g., Docker Hub credentials, GCP credentials, MySQL passwords) and variables in your GitHub repository under Actions > Secrets & Variable