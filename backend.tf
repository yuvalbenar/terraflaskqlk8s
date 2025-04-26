terraform {
  backend "gcs" {
    bucket = "terraflaskqlk8s-terraform-state"
    prefix = "terraform/state"
  }
}
