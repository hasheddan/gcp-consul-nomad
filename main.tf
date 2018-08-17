# ---------------------
# PROVIDER
# ---------------------

# Provider - GCP

provider "google" {
  project = "${var.gcp_project}"
}

# ---------------------
# REQUIREMENTS
# ---------------------

# Require Terraform v0.10.3 or higher

terraform {
  required_version = ">= 0.10.3"
}

# ---------------------
# MODULES
# ---------------------

# # Nomad / Consul Servers

module "servers" {
  # Location of the server cluster module
  source = "./modules/cluster"

  # Image to be used for compute instances in the cluster
  source_image = "ubuntu-1804-bionic-v20180808"

  # Script to run to start Nomad / Consul / Docker on compute instance boot
  startup_script = "${file("${path.module}/scripts/server-startup.sh")}"

  name = "servers"

  size = 3
}

module "clients" {
  # Location of the server cluster module
  source = "./modules/cluster"

  # Image to be used for compute instances in the cluster
  source_image = "ubuntu-1804-bionic-v20180808"

  # Script to run to start Nomad / Consul / Docker on compute instance boot
  startup_script = "${file("${path.module}/scripts/client-startup.sh")}"

  name = "clients"

  size = 2
}
