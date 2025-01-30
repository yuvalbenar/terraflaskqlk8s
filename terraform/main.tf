provider "google" {
  project     = "terraflaskqlk8s" # Update this to match your actual GCP project ID
  region      = "us-east1"       # Use the region only (not zone, e.g., "us-east1")
  credentials = var.GCP_CREDENTIALS
}

resource "google_container_cluster" "flasksql_cluster" {
  name               = "flasksql-cluster"
  location           = "us-east1-b"  # Zone (e.g., "us-east1-b")
  initial_node_count = 2

  node_config {
    machine_type = "e2-medium"
  }
}
