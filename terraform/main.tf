resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "subnet" {
  name                     = "terraform-subnetwork"
  ip_cidr_range            = var.subnet_cidr
  region                   = var.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
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

  source_ranges = [var.allowed_ssh_cidr]
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
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["ssh", "web"]

  boot_disk {
    initialize_params {
      image = var.boot_image
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
