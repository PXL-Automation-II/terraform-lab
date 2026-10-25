# 52 - Modules workshop

End state of the [Terraform modules workshop](https://pxl-automation-ii.github.io/terraform-course/#/52-modules-workshop).

- `live`:
  - The configurations you deploy, per environment and component.
- `modules`:
  - The reusable modules, as released in [tf-lab-modules](https://github.com/PXL-Automation-II/tf-lab-modules) `v0.2.2`.
  - The clusters use the released versions: staging `v0.2.2`, prod `v0.1.2`.
    - These patch releases match the `v0.2.0` and `v0.1.0` of the workshop.
    - They look up the Ubuntu AMI, and put the instances only in the Availability Zones that offer the instance type.
  - The databases use the local path `../../../../modules/data-storage/mysql`.

Before you run anything:

- Replace `terraform-pxl-state-1234` with your own bucket name, in `live/00-backend-bootstrap/backend_resources.tf`, in every `backend.hcl`, and in both cluster `main.tf` files.
- To use your own module repository, replace `github.com/PXL-Automation-II/tf-lab-modules` with `github.com/YOUR-USER/terraform-modules`.

Order, in every directory with `terraform init -backend-config=./backend.hcl` and `terraform apply`:

1. `live/00-backend-bootstrap` (once, only `terraform init`, no backend.hcl)
2. `live/staging/data-storage/mysql` and `live/prod/data-storage/mysql`
3. `live/staging/services/webserver-cluster` and `live/prod/services/webserver-cluster`

The databases need the credentials as environment variables, in bash:

```bash
export TF_VAR_db_username="pxl"
export TF_VAR_db_password="pxlpxlpxl"
```

In PowerShell:

```powershell
$env:TF_VAR_db_username = "pxl"
$env:TF_VAR_db_password = "pxlpxlpxl"
```

Destroy in the reverse order: the clusters first, then the databases. Keep the bucket.
