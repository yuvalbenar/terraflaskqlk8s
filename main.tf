provider "google" {
  project     = "terraflaskqlk8s"  # Replace with your GCP project ID
  region      = "us-east1"          # Use the region (not zone, e.g., "us-east1")
  credentials = file(env.GCP_CREDENTIALS)  # Directly use the environment variable
}

resource "google_container_cluster" "flasksql_cluster" {
  name               = "flasksql-cluster"
  location           = "us-east1-b"  # Zone (e.g., "us-east1-b")
  initial_node_count = 2

  node_config {
    machine_type = "e2-medium"
  }
}
