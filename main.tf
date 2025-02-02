provider "google" {
  project     = "terraflaskqlk8s"
  region      = "us-east1"
  credentials = file(var.credentials_path)
}


resource "google_container_cluster" "flasksql_cluster" {
  name               = "flasksql-cluster"
  location           = "us-east1-b"  # Zone (e.g., "us-east1-b")
  initial_node_count = 2

  node_config {
    machine_type = "e2-medium"
  }
}
