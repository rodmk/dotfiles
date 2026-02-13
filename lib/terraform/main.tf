provider "hcloud" {} # uses HCLOUD_TOKEN env var

locals {
  imports = jsondecode(file("${path.module}/imports.json"))
}

data "hcloud_ssh_key" "default" {
  name = "Hetzner SSH Key"
}

resource "hcloud_server" "dev" {
  name         = local.imports["hcloud_server.dev"]
  server_type  = "cpx11"
  location     = "hil"
  image        = "ubuntu-24.04"
  ssh_keys     = [data.hcloud_ssh_key.default.id]
  firewall_ids = [hcloud_firewall.dev.id]
  user_data    = file("${path.module}/../cloud-init.yaml")

  lifecycle {
    ignore_changes = [user_data, image]
  }
}

resource "hcloud_firewall" "dev" {
  name = local.imports["hcloud_firewall.dev"]

  rule {
    description = "SSH"
    direction   = "in"
    protocol    = "tcp"
    port        = "22"
    source_ips  = ["0.0.0.0/0", "::/0"]
  }

  rule {
    description = "Mosh"
    direction   = "in"
    protocol    = "udp"
    port        = "60000-61000"
    source_ips  = ["0.0.0.0/0", "::/0"]
  }

  rule {
    description = "ET"
    direction   = "in"
    protocol    = "tcp"
    port        = "2022"
    source_ips  = ["0.0.0.0/0", "::/0"]
  }
}

output "ip" {
  value = hcloud_server.dev.ipv4_address
}

output "status" {
  value = hcloud_server.dev.status
}
