resource "google_compute_instance_template" "server_template" {
  count   = "${var.module_enabled ? 1 : 0}"
  project = "${var.project}"

  name_prefix  = "instance-template-"
  machine_type = "${var.machine_type}"
  region       = "${var.region}"

  tags = "${var.tags}"

  # Boot Disk
  disk {
    source_image = "${var.source_image}"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network = "default"

    # Enables SSH
    access_config = {}
  }

  # Merge startup script to any other metadata provided
  metadata = "${merge(
    map("startup-script", "${var.startup_script}"),
    var.metadata
  )}"

  service_account {
    scopes = [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/compute.readonly",
    ]
  }
}

resource "google_compute_instance_group_manager" "default" {
  count       = "${var.module_enabled && var.zonal ? 1 : 0}"
  project     = "${var.project}"
  name        = "${var.name}"
  description = "compute VM Instance Group"

  base_instance_name = "${var.name}"

  instance_template = "${google_compute_instance_template.server_template.self_link}"

  zone = "${var.zone}"

  update_strategy = "${var.update_strategy}"

  target_size = "${var.size}"

  named_port {
    name = "http"
    port = 80
  }
}
