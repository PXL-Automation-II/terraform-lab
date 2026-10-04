Set environment variables to use as Terraform variables.

bash:

```bash
export TF_VAR_db_username="pxl"
export TF_VAR_db_password="pxlpxlpxl"
```

PowerShell:

```powershell
$env:TF_VAR_db_username = "pxl"
$env:TF_VAR_db_password = "pxlpxlpxl"
```

Then initialize with the backend settings and apply:

```bash
terraform init -backend-config="./backend.hcl"
terraform apply
```
