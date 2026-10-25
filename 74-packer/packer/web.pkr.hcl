packer {
  required_version = ">= 1.16.0"

  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.8"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1.1"
    }
  }
}

variable "app_version" {
  description = "Version of the web page, also in the name and tags of the image"
  type        = string
  default     = "1.0.0"
}

locals {
  # 20261025-0930: the time of the build, so every image name is unique
  build_time = formatdate("YYYYMMDD-hhmm", timestamp())
}

source "amazon-ebs" "web" {
  region        = "us-east-1"
  instance_type = "t3.micro"
  ssh_username  = "ubuntu"
  ami_name      = "pxl-web-${var.app_version}-${local.build_time}"

  # The newest base image of this account, built from base.pkr.hcl
  source_ami_filter {
    filters = {
      "tag:Name" = "pxl-base"
    }
    owners      = ["self"]
    most_recent = true
  }

  tags = {
    Name    = "pxl-web"
    Version = var.app_version
    Stage   = "dev"
  }
}

build {
  sources = ["source.amazon-ebs.web"]

  # Wait until the instance has booted, then install Ansible on it
  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    inline = [
      "cloud-init status --wait",
      "sudo apt-get update -q",
      "sudo -E apt-get install -y -q --no-install-recommends ansible-core",
    ]
  }

  # Run the playbook on the build instance itself
  provisioner "ansible-local" {
    playbook_file           = "ansible/web.yml"
    extra_arguments         = ["--extra-vars", "app_version=${var.app_version}"]
    command                 = "ANSIBLE_NOCOLOR=1 ansible-playbook"
    clean_staging_directory = true
  }

  # Test the image before Packer saves it, and remove Ansible again
  provisioner "shell" {
    inline = [
      "curl --fail --silent http://localhost/ | grep '${var.app_version}'",
      "sudo apt-get purge -y -q ansible-core",
      "sudo apt-get autoremove -y -q",
    ]
  }

  # Write the ID of the new image to manifest.json
  post-processor "manifest" {
    output = "manifest.json"
  }
}
