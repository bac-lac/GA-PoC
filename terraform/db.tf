resource "aws_db_subnet_group" "data" {
  name       = "ga-db-subnet-group-${var.BRANCH_NAME}"
  subnet_ids = data.aws_subnets.data.ids
}

resource "aws_db_instance" "ga_mysql" {
  allocated_storage               = 20
  db_name                         = format("GA%s", replace("${var.BRANCH_NAME}", "-", ""))
  engine                          = "mysql"
  engine_version                  = "8.0.35"
  instance_class                  = "db.t3.micro"
  username                        = var.ADMIN_DB_USERNAME
  password                        = var.ADMIN_DB_PASSWORD
  parameter_group_name            = "default.mysql8.0"
  skip_final_snapshot             = true
  storage_encrypted               = true
  vpc_security_group_ids          = [data.aws_security_group.data.id]
  db_subnet_group_name            = aws_db_subnet_group.data.name
  #monitoring_interval            = 5  -> need monitoring_role_arn 
  enabled_cloudwatch_logs_exports = ["general", "error", "slowquery"]
  backup_retention_period         = 35
  performance_insights_enabled    = true
}