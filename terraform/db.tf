resource "aws_db_subnet_group" "data" {
  name       = "ga-db-subnet-group-${var.BRANCH_NAME}"
  subnet_ids = data.aws_subnets.data.ids
}

resource "aws_db_instance" "ga_mysql" {
  allocated_storage               = 20
  apply_immediately               = true
  auto_minor_version_upgrade      = true
  backup_retention_period         = 35
  copy_tags_to_snapshot           = true
  db_name                         = format("GA%s", replace("${var.BRANCH_NAME}", "-", ""))
  db_subnet_group_name            = aws_db_subnet_group.data.name
  enabled_cloudwatch_logs_exports = ["audit", "general", "error", "slowquery"]
  engine                          = "mysql"
  engine_version                  = "8.0.35"
  identifier                      = "ga-db-${var.BRANCH_NAME}"
  instance_class                  = "db.t3.medium"
  monitoring_interval             = 5
  monitoring_role_arn             = aws_iam_role.ga_rds_monitoring_role.arn
  parameter_group_name            = "default.mysql8.0"
  password                        = var.ADMIN_DB_PASSWORD
  performance_insights_enabled    = true
  skip_final_snapshot             = true
  storage_encrypted               = true
  username                        = var.ADMIN_DB_USERNAME
  vpc_security_group_ids          = [data.aws_security_group.data.id]
}