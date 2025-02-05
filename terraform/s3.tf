resource "aws_s3_bucket" "ga_s3" {
  bucket = "s3-access-logs-${var.ACCOUNT}-ca-central-1"
  bucket_prefis = "${var.BRANCH_NAME}"

  tags = {
    Name        = "${var.BRANCH_NAME}-s3-access-logs-${var.ACCOUNT}-ca-central-1"
    Environment = "Dev"
  }
  force_destroy = true
}