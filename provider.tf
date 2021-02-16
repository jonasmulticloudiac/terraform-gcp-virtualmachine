provider "google" {
  credentials = file(var.sa-creds)

  project = var.project
  region  = var.region
  zone    = var.zone
}

resource "google_compute_network" "vpc" {
  name = "web-vpc"
}