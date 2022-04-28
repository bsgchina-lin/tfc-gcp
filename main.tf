provider "google" {
  credentials = var.google_credentials
  project     = "xxnet-2020"
  region      = "us-central1"
  zone        = "us-central1-c"
}

variable "google_credentials" {
  default = "tfc-gcp-2022"
}



resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}
