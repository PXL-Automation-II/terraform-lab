# backend.hcl
bucket         = "terraform-pxl-state"
region         = "us-east-1"
dynamodb_table = "terraform-pxl-locks"
encrypt        = true
