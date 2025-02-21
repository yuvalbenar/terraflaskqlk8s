CI/CD Workflow Explanation
The project uses GitHub Actions for continuous integration and deployment:

Build Stage:

Checks out the code and logs into Docker Hub.
Builds the Docker image with no cache and tags it as latest.
Pushes the image to Docker Hub.
Build-Test Stage:

Re-checks out the code and sets necessary environment variables.
Uses Docker Compose to rebuild and run the application in a multi-container setup.
Runs tests (using curl) to verify the application is reachable on the defined port.
Uploads key artifacts (like IMAGE_TAG) for later stages.
Helm Stage:

Updates the Helm chart version based on version.txt.
Packages the Helm chart and updates the Helm repository.
Pushes the updated Helm chart to the repository.
Terraform & Deploy Stages:

Use Terraform to provision GKE cluster infrastructure.
Deploy the application to GKE using Helm and update Kubernetes resources.
Verify-Monitoring Stage:

Installs and configures Prometheus using the kube-prometheus-stack Helm chart.
Verifies that monitoring is active and collecting metrics from the deployed application.

Deployment Steps
Image Build & Test:
A Docker image is built, tagged as latest, and pushed to Docker Hub.
Docker Compose is used to start containers and run integration tests.
Helm Chart Packaging:
The Helm chart is updated with a new version (tracked in version.txt), packaged, and pushed to your Helm repository.
Infrastructure Provisioning:
Terraform is used to set up the necessary infrastructure on GKE.
Application Deployment:
The application is deployed to GKE using Helm. Kubernetes Secrets, ConfigMaps, and Services are patched for Helm adoption.
Monitoring Setup:
A Prometheus-based monitoring stack is deployed and configured to scrape metrics from your application endpoints.
Security Considerations
Secrets Management:
Sensitive data (e.g., database credentials, Docker Hub credentials, GCP credentials) are stored securely as GitHub Secrets.

Network Policies:
Implement Kubernetes Network Policies to restrict traffic between pods and external networks.

Monitoring Setup
Prometheus Integration:
The application exposes metrics on the /metrics endpoint, which are scraped by a Prometheus Operator running in the cluster.
Grafana Dashboards:
Grafana is configured (or will be configured) to visualize metrics from Prometheus. Dashboards display key metrics such as visitor count, application performance, and system health.
Alerting:email will be sent if visitor count on website reahces 4000, working on machenich to automaticly open a new pod for extra suppert.