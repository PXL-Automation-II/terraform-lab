terraform {
  required_version = ">= 1.11.0"
  required_providers {
    awscc = {
      source  = "hashicorp/awscc"
      version = "~> 1.0"
    }
  }
}

# awscc (AWS Cloud Control) instead of the aws provider: in the AWS Academy
# Learner Lab, aws_s3_bucket fails on every read because a Service Control
# Policy blocks s3:GetBucketObjectLockConfiguration.
provider "awscc" {
  region = "us-east-1"
}
