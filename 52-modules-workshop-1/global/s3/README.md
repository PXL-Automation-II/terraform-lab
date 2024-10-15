1. comment out backend "s3" section in main.tf
2. `terraform init`
3. `terraform apply`
4. remove comments
5. useage of partial config file for backend:

bash:
```bash
terraform init -backend-config=config.s3.tfbackend -reconfigure
```

powershell:
```powershell
terraform init -backend-config config.s3.tfbackend -reconfigure
```
6. `terraform apply`
