resource "aws_db_subnet_group" "data" {
  name       = "ga-db-subnet-group-${var.BRANCH_NAME}"
  subnet_ids = data.aws_subnets.data.ids
}

resource "aws_db_instance" "ga_mysql" {
  allocated_storage               = 20
  db_name                         = format("GA%s", replace("${var.BRANCH_NAME}", "-", ""))
  engine                          = "mysql"
  engine_version                  = "8.0.35"
  instance_class                  = "db.t3.medium"
  username                        = var.ADMIN_DB_USERNAME
  password                        = var.ADMIN_DB_PASSWORD
  parameter_group_name            = "default.mysql8.0"
  skip_final_snapshot             = true
  storage_encrypted               = true
  vpc_security_group_ids          = [data.aws_security_group.data.id]
  db_subnet_group_name            = aws_db_subnet_group.data.name
  enabled_cloudwatch_logs_exports = ["general", "error", "slowquery"]
  backup_retention_period         = 35
  performance_insights_enabled    = true
  copy_tags_to_snapshot           = true
  apply_immediately               = true
  identifier                      = "ee-instance-demo"
  monitoring_interval             = 5
  monitoring_role_arn             = aws_iam_role.ga_rds_role.arn
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ga_rds_monitoring_role" {
  name                = "ga_rds_monitoring_role-${var.BRANCH_NAME}"
  description         = "Provides access to Cloudwatch for RDS Enhanced Monitoring"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"]
}