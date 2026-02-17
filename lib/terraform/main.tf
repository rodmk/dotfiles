variable "op_sa_token" {
  type      = string
  default   = ""
  sensitive = true
}

provider "hcloud" {} # uses HCLOUD_TOKEN env var

locals {
  imports = jsondecode(file("${path.module}/imports.json"))
  config  = jsondecode(file("${path.module}/config.json"))
}

data "hcloud_ssh_key" "default" {
  name = "Hetzner SSH Key"
}

resource "hcloud_server" "dev" {
  name         = local.imports["hcloud_server.dev"]
  server_type  = local.config.server_type
  location     = local.config.location
  image        = local.config.base_image
  ssh_keys     = [data.hcloud_ssh_key.default.id]
  firewall_ids = [hcloud_firewall.dev.id]
  user_data = templatefile("${path.module}/../cloud-init.yaml.tftpl", {
    op_sa_token = var.op_sa_token
    ssh_pubkey  = data.hcloud_ssh_key.default.public_key
  })

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

}

output "ip" {
  value = hcloud_server.dev.ipv4_address
}

output "status" {
  value = hcloud_server.dev.status
}
