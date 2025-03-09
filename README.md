## TerraFlaskQLK8s 🐶 – Your Daily Beagle Treat!
TerraFlaskQLK8s is an automated, containerized deployment solution for a Flask application. It leverages GitHub Actions for continuous integration and deployment,Docker for containerization,Terraform and Helm for provisioning and deployment on Google Kubernetes Engine (GKE), and Prometheus/Grafana for monitoring.

## Table of Contents
- [Architecture Diagram](#architecture-diagram)
- [Key Features](#key-features)
- [Quick Start](#quick-start)
- [CI/CD Workflow Overview](#cicd-workflow-overview)
- [Prerequisites](#prerequisites)
- [Configuration](#configuration)
- [Overview](#overview)

#### Architecture Diagram
![alt text](images/hopefullyifinaldiagram.svg)



This diagram outlines the key components of the system and their interactions.

#### Key Features
CI/CD Pipeline:
Automated builds, tests, and deployments via GitHub Actions.

Containerization:
Dockerized application ensures consistency across environments.

Infrastructure as Code:
Terraform provisions the GKE cluster while Helm manages Kubernetes deployments.

Monitoring & Alerting:
Prometheus and Grafana monitor application performance and trigger alerts as needed, loki used for logging.

Security & Best Practices:
Use of .dockerignore and .gitignore to protect sensitive information.

#### Quick Start
Clone the Repository
bash
Copy
git clone https://github.com/YourUsername/terraflaskqlk8s.git
cd terraflaskqlk8s
Install Dependencies
bash
Copy
pip install -r requirements.txt
Run the Application Locally
Start the Flask server by running:

bash
Copy
flask run
The Flask server will start on the default port (5000). Adjust the command or configuration if you use a different port.

Test with Docker Compose
To test the multi-container setup locally:

bash
Copy
docker compose up --build
curl http://localhost:5000

#### CI/CD Workflow Overview

**Build Stage:**
The source code is checked out and a Docker image is built and tagged as latest.
The image is then pushed to Docker Hub.

**Test Stage:**
Docker Compose spins up a multi-container environment.
Integration tests (e.g., curl tests) verify that the application is functioning as expected.

**Helm Stage:**
A new version is computed (e.g., 0.0.${{ github.run_number }}) and stored in version.txt.
The Docker image is re-tagged with the new version and pushed.
The Helm chart is updated to use the new version, packaged, and pushed to the Helm repository.

**Deployment Stage:**
Terraform provisions or updates the GKE cluster.
Helm deploys the updated application to the cluster.

**Monitoring:**
Prometheus scrapes application metrics.
Grafana displays dashboards and alerts for operational monitoring.
Prerequisites
Python 3.8+
Docker & Docker Compose
GitHub Actions enabled in your repository
Terraform
Helm
Configuration
Before running the pipeline, ensure that you have configured the necessary secrets (e.g., Docker Hub credentials, GCP credentials, MySQL passwords) and variables in your GitHub repository under Actions > Secrets & Variables.

__For persistent monitoring,__ the Helm values configure Prometheus and Grafana as follows:
Prometheus:
Uses a persistent volume (20Gi, storage class standard-wffc) to retain historical metrics.
Grafana:
Uses a persistent volume (10Gi, storage class standard) to store dashboards and configuration.
You can review and adjust these settings in your prometheus_values.yaml.
 