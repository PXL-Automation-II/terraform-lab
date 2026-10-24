bucket       = "terraform-pxl-state-1234" # the bucket from 00-backend-bootstrap
region       = "us-east-1"
use_lockfile = true # native S3 locking (Terraform 1.11+)
encrypt      = true
