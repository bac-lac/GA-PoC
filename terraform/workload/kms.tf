resource "aws_kms_key" "ga_kms_key" {
  description   = "This custom managed key is used for cloudwatch alarms sent to SNS topics."
  policy        = jsonencode({
    Version = "2012-10-17"
    Id      = "key-consolepolicy-3"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.ACCOUNT}:root"
        },
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow use of the key"
        Effect = "Allow"
        Principal = {
          Service = "cloudwatch.amazonaws.com"
        },
        Action = [
          "kms:Decrypt",
          "kms:GenerateDataKey"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_kms_alias" "a" {
  name          = "alias/${var.BRANCH_ENV}"
  target_key_id = aws_kms_key.ga_kms_key.key_id
}