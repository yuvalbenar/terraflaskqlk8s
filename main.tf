provider "google" {
  project     = "terraflaskqlk8s"
  region      = "us-east1"
  credentials = file(var.credentials_path)  # Path to the credentials
}

resource "google_container_cluster" "flasksql_cluster" {
  name               = "flasksql-cluster"
  location           = "us-east1-b"   # Update this if needed
  initial_node_count = 1               # You can change the node count as needed

  # Ensure the right service account is set
  node_config {
    service_account = "terracicd-sa@terraflaskqlk8s.iam.gserviceaccount.com"
  }

  # Optional settings like enabling Kubernetes Dashboard, etc.
  
}
