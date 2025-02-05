resource "aws_s3_bucket" "ga_s3" {
  bucket = "${var.BRANCH_NAME}-s3-access-logs-${var.ACCOUNT}-ca-central-1"

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

resource "aws_s3_bucket_policy" "allow-lb" {
  bucket = aws_s3_bucket.ga_s3.id
  policy = data.aws_iam_policy_document.ga_s3_allow_lb.json
}