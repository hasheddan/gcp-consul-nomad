# Firewalls for nomad server
resource "google_compute_firewall" "nomad-ui" {
  name        = "allow-nomad-ui"
  description = "Allow Nomad UI from everywhere."
  network     = "default"

  allow {
    protocol = "tcp"
    ports    = ["4646"]
  }

  # Nomad UI is accessible by everyone
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["nomad"]
}

# Firewalls for consul server
resource "google_compute_firewall" "consul-ui" {
  name        = "allow-consul-ui"
  description = "Allow Consul UI from everywhere."
  network     = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["consul"]
}
