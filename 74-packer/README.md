# 74 - Packer

End state of [Packer with Ansible and Terraform](https://pxl-automation-ii.github.io/terraform-course/#/74-packer): a web server image built with Packer and Ansible, on top of a base image, and started with Terraform.

- `packer/base`: the base image, `pxl-base`, with the settings every server needs.
- `packer`: the web image, `pxl-web`, with nginx and a page. It starts from the newest `pxl-base` image.
- `terraform`: a web server from the newest `pxl-web` image with the tag `Stage = dev`.
- `.github/workflows/image.yml`: the pipeline that builds the web image on the self-hosted runner of [chapter 78](https://pxl-automation-ii.github.io/terraform-course/#/78-github-actions). It only works in the root of a repository.

Ansible runs on the build instance, so you only need Packer and Terraform on your computer.

Build the base image first, then the web image, then start the server:

```bash
cd packer/base
packer init .
packer build .
cd ..
packer init .
packer build .
cd ../terraform
terraform init
terraform apply
```

Clean up with `terraform destroy`, and deregister the images with `aws ec2 deregister-image --image-id <ami> --delete-associated-snapshots`, as the page describes.
