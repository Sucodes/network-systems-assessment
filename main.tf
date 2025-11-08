terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.8.0"
    }
  }
}

provider "google" {
  project = "network-systems-assessment"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "terraform-subnetwork"
  ip_cidr_range = "10.0.0.0/24"
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "allow_ssh" {
  name        = "terraform-firewall-allow-ssh"
  network     = google_compute_network.vpc_network.id
  direction   = "INGRESS"
  priority    = 1000
  target_tags = ["ssh"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["79.140.223.114/32"]
}

resource "google_compute_firewall" "allow_web" {
  name        = "terraform-firewall-allow-web"
  network     = google_compute_network.vpc_network.id
  direction   = "INGRESS"
  priority    = 1000
  target_tags = ["web"]

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "vm_instance" {
  name         = "vm-instance"
  machine_type = "e2-medium"
  zone         = "us-central1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.subnet.id

    access_config {}
  }
}
