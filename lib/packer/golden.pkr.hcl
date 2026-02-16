packer {
  required_plugins {
    hcloud = {
      source  = "github.com/hetznercloud/hcloud"
      version = ">= 1.7.0"
    }
  }
}

locals {
  config     = jsondecode(file("${path.root}/../terraform/config.json"))
  label_parts = split("=", local.config.snapshot_label)
}

source "hcloud" "golden" {
  image           = local.config.base_image
  location        = local.config.location
  server_type     = local.config.server_type
  ssh_username    = "root"
  snapshot_name   = "golden-{{timestamp}}"
  snapshot_labels = { (local.label_parts[0]) = local.label_parts[1] }
  user_data_file  = "${path.root}/../cloud-init.yaml"
}

build {
  sources = ["source.hcloud.golden"]

  provisioner "shell" {
    inline = [
      "cloud-init status --wait",
      "cloud-init clean --logs",
    ]
  }
}
