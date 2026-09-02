data "aws_kms_alias" "ga_kms_main" {
  name = "alias/main"
}

data "aws_kms_alias" "efs" {
  name = "alias/aws/elasticfilesystem"
}
