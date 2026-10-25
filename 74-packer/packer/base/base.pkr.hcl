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

locals {
  build_time = formatdate("YYYYMMDD-hhmm", timestamp())
}

source "amazon-ebs" "base" {
  region        = "us-east-1"
  instance_type = "t3.micro"
  ssh_username  = "ubuntu"
  ami_name      = "pxl-base-${local.build_time}"

  source_ami_filter {
    filters = {
      name = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    }
    owners      = ["099720109477"] # Canonical
    most_recent = true
  }

  tags = {
    Name = "pxl-base"
  }
}

build {
  sources = ["source.amazon-ebs.base"]

  provisioner "shell" {
    environment_vars = ["DEBIAN_FRONTEND=noninteractive"]
    inline = [
      "cloud-init status --wait",
      "sudo apt-get update -q",
      "sudo -E apt-get install -y -q --no-install-recommends ansible-core",
    ]
  }

  provisioner "ansible-local" {
    playbook_file           = "ansible/base.yml"
    command                 = "ANSIBLE_NOCOLOR=1 ansible-playbook"
    clean_staging_directory = true
  }

  provisioner "shell" {
    inline = [
      "sudo apt-get purge -y -q ansible-core",
      "sudo apt-get autoremove -y -q",
    ]
  }
}
