provider "google" {
  region      = "${var.region}"
  project     = "${var.project_name}"
#  credentials = "${file(var.account_file_path)}"
}

resource "google_container_cluster" "primary" {
  name               = "k8s-cluster"
  zone               = "europe-west1-c"
  initial_node_count = 3

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "cloud-platform",
    ]
  }
}

output "client_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.primary.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
}
