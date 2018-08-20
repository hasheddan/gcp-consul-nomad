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
  # Location of the cluster module
  source = "./modules/cluster"

  # Image to be used for compute instances in the cluster
  source_image = "ubuntu-1804-bionic-v20180808"

  tags = ["consul-server", "nomad-server"]

  # Script to run to start Nomad / Consul on compute instance boot
  startup_script = "${file("${path.module}/scripts/server-startup.sh")}"

  name = "servers"

  size = 3
}

module "clients" {
  # Location of the cluster module
  source = "./modules/cluster"

  # Image to be used for compute instances in the cluster
  source_image = "ubuntu-1804-bionic-v20180808"

  tags = ["nomad-client"]

  # Script to run to start Nomad / Consul on compute instance boot
  startup_script = "${file("${path.module}/scripts/client-startup.sh")}"

  name = "clients"

  size = 2
}

module "security" {
  # Location of the security module
  source = "./modules/security"
}
