variable "GCP_CREDENTIALS" {
  description = "Path to the GCP credentials file"
  type        = string
  default     = "/tmp/gcp_credentials.json"  # Or a path to a local credentials file
}
