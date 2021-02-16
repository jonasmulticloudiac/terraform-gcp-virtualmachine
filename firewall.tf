resource "google_compute_firewall" "default" {
  name    = "web-fire"
  network = google_compute_network.vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "22"]
  }
  source_ranges = ["0.0.0.0/0"]
  source_tags   = ["http-server"]
}

