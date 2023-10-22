packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.1.1"
    }
  }
}
source "amazon-ebs" "custom-ami" {
  ami_name      = "packer-pxl-custom-ami-{{timestamp}}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  source_ami    = "ami-08c40ec9ead489470"
  ssh_username  = "ubuntu"
  profile       = "default"
  tags = {
    Name = "packer-pxl-custom-ami"
  }
}
build {
  sources = ["source.amazon-ebs.custom-ami"]

  provisioner "ansible" {
    playbook_file = "./playbook.yaml"
    user          = "ubuntu"
    extra_arguments = [ "-e", "ansible_ssh_common_args='-o HostKeyAlgorithms=+ssh-rsa'" ]
  }
}
