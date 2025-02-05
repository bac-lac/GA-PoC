resource "aws_s3_bucket" "ga_s3" {
  bucket = "s3-access-logs-${var.ACCOUNT}-ca-central-1"
  bucket_prefis = "${var.BRANCH_NAME}"

  tags = {
    Name        = "${var.BRANCH_NAME}-s3-access-logs-${var.ACCOUNT}-ca-central-1"
    Environment = "Dev"
  }
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "default" {
  bucket = aws_s3_bucket.ga_s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "default" {
  bucket = aws_s3_bucket.ga_s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}