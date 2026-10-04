resource "awscc_s3_bucket" "terraform_state" {
  bucket_name = "terraform-pxl-state" # replace with a globally unique name

  # Keep the full revision history of your state files
  versioning_configuration = {
    status = "Enabled"
  }

  # Server-side encryption with SSE-S3
  bucket_encryption = {
    server_side_encryption_configuration = [{
      server_side_encryption_by_default = {
        sse_algorithm = "AES256"
      }
    }]
  }

  # Block all public access
  public_access_block_configuration = {
    block_public_acls       = true
    block_public_policy     = true
    ignore_public_acls      = true
    restrict_public_buckets = true
  }

  # Prevent accidental deletion of this S3 bucket
  lifecycle {
    prevent_destroy = true
  }
}
