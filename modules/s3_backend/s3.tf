# Creating S3 bucket
resource "aws_s3_bucket" "terraform_state" {
  bucket = var.bucket_name

  tags = {
    Name        = "Terraform State Bucket"
    Environment = "dev"
  }
}

# Enabling versioning for the S3 bucket
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Setting ownership controls for the S3 bucket
resource "aws_s3_bucket_ownership_controls" "terraform_state_ownership" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}