2 stage initialization

stage 1: create S3 bucket and dynamodb
1. comment out backend "s3" section in main.tf
2. `terraform init`
3. `terraform apply`

stage 2: move backend to s3/dynamodb
4. remove comments
5. useage of partial config file for backend:

bash:
```bash
terraform init -backend-config=config.s3.tfbackend -reconfigure
```

powershell does not parse `=` properly:
```powershell
terraform init -backend-config config.s3.tfbackend -reconfigure
```
6. `terraform apply`
