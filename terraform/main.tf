provider "google" {
  project     = "terraflaskqlk8s"
  region      = "us-east1"
  credentials = var.gcp_credentials
}

resource "google_container_cluster" "flasksql_cluster" {
  name               = "flasksql-cluster"
  location           = "us-east1-b"
  initial_node_count = 2

  node_config {
    machine_type = "e2-medium"
  }
}
