variable module_enabled {
  description = "Denotes whether a template should be generated or not."
  default     = true
}

variable project {
  description = "The project to deploy to, if not set the default provider project is used."
  default     = ""
}

variable "machine_type" {
  description = "Type of VM specified for each node."
  default     = "f1-micro"
}

variable region {
  description = "Region for cloud resources."
  default     = "us-central1"
}

variable "source_image" {
  description = "Image to be used for compute instances in the cluster."
  default     = "ubuntu-1804-bionic-v20180808"
}

variable "tags" {
  description = "Tags associated with compute instance."
  default     = []
}

variable "startup_script" {
  description = "Script to run to start Nomad / Consul / Docker on compute instance boot."
}

variable metadata {
  description = "Map of metadata values to pass to instances."
  type        = "map"
  default     = {}
}

variable "name" {
  description = "Name of the managed instance group."
}

variable zonal {
  description = "Create a single-zone managed instance group. If false, a regional managed instance group is created."
  default     = true
}

variable zone {
  description = "Zone for managed instance groups."
  default     = "us-central1-f"
}

variable update_strategy {
  description = "The strategy to apply when the instance template changes."
  default     = "NONE"
}

variable size {
  description = "Target size of the manged instance group."
  default     = 1
}
