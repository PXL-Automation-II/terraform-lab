packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.1.1"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = "~> 1"
    }
  }
}
source "amazon-ebs" "custom-ami" {
  ami_name      = "packer-pxl-custom-ami-{{timestamp}}"
  instance_type = "t3.micro"
  region        = "us-east-1"
  ssh_username  = "ubuntu"

  # The newest Ubuntu 24.04 image of Canonical, instead of a fixed source_ami ID
  source_ami_filter {
    filters = {
      name = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"
    }
    most_recent = true
    owners      = ["099720109477"] # Canonical
  }
  profile = "default"
  tags = {
    Name = "packer-pxl-custom-ami"
  }
}
build {
  sources = ["source.amazon-ebs.custom-ami"]

  provisioner "ansible" {
    playbook_file   = "./playbook.yaml"
    user            = "ubuntu"
    extra_arguments = ["-e", "ansible_ssh_common_args='-o HostKeyAlgorithms=+ssh-rsa'"]
  }
}
