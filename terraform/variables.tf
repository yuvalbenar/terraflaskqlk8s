provider "google" {
  credentials = jsondecode(var.gcp_credentials)
  project     = "terraflaskqlk8s"
  region      = "us-central1"
}
