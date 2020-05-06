variable "hcloud_api_token" {}

provider "hcloud" {
  token = var.hcloud_api_token
}

# Create a web server
resource "hcloud_server" "devtools" {
  image       = "ubuntu-18.04"
  name        = "devtools"
  location    = "hel1"
  server_type = "cx11"
  ssh_keys    = [1449416]

  provisioner "remote-exec" {
    script = "scripts/remote-config.sh"

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      private_key = file("~/.ssh/devtools")
      user        = "root"
      timeout     = "2m"
    }
  }

  provisioner "file" {
    source      = "scripts/installs.sh"
    destination = "installs.sh"

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      private_key = file("~/.ssh/devtools")
      user        = "user"
      timeout     = "2m"
    }
  }

  provisioner "file" {
    source      = "scripts/docker-compose.yml"
    destination = "docker-compose.yml"

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      private_key = file("~/.ssh/devtools")
      user        = "user"
      timeout     = "2m"
    }
  }

  provisioner "file" {
    source      = "scripts/nginx.conf"
    destination = "nginx.conf"

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      private_key = file("~/.ssh/devtools")
      user        = "user"
      timeout     = "2m"
    }
  }

  provisioner "file" {
    source      = "scripts/openvpn.conf"
    destination = "openvpn.conf"

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      private_key = file("~/.ssh/devtools")
      user        = "user"
      timeout     = "2m"
    }
  }

  provisioner "file" {
    source      = "scripts/rules.v4"
    destination = "rules.v4"

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      private_key = file("~/.ssh/devtools")
      user        = "user"
      timeout     = "2m"
    }
  }

  provisioner "file" {
    source      = "scripts/vpn.sh"
    destination = "vpn.sh"

    connection {
      type        = "ssh"
      host        = self.ipv4_address
      private_key = file("~/.ssh/devtools")
      user        = "user"
      timeout     = "2m"
    }
  }
}

output "public_ip" {
  value = "ssh -i ~/.ssh/devtools user@${hcloud_server.devtools.ipv4_address}"
}

output "public_ip" {
  value = "scp -i ~/.ssh/devtools user@${hcloud_server.devtools.ipv4_address}:client.ovpn ~/Desktop"
}