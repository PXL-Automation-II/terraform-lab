output "s3_bucket_name" {
  value       = awscc_s3_bucket.terraform_state.bucket_name
  description = "The name of the S3 bucket"
}

output "s3_bucket_arn" {
  value       = awscc_s3_bucket.terraform_state.arn
  description = "The ARN of the S3 bucket"
}
