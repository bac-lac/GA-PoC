locals {
  db_instance_memory = {
    "db.t3.micro"  = 1
    "db.t3.small"  = 2
    "db.t3.medium" = 4
    "db.t3.large"  = 8
  }
}

output "db_instance_memory_size" {
  value = lookup(local.db_instance_memory, aws_db_instance.ga_mysql.instance_class)
}

output "db_allocated_storage" {
  value = aws_db_instance.ga_mysql.allocated_storage
}

resource "aws_cloudwatch_metric_alarm" "ga_cw_db_cpu_alarm" {
  alarm_name                = "MySQL ${var.BRANCH_NAME} High CPU Utilization"
  comparison_operator       = "GreaterThanThreshold"
  alarm_actions             = [aws_sns_topic.ga_sns_topic.arn]
  insufficient_data_actions = []
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  statistic                 = "Maximum"
  dimensions = {
    DBInstanceIdentifier  = aws_db_instance.ga_mysql.identifier
  }
  period                    = 60
  evaluation_periods        = 1
  datapoints_to_alarm       = 1
  threshold                 = 80
  treat_missing_data        = "missing"
  alarm_description         = "This metric monitors RDS ${var.BRANCH_NAME} cpu utilization"
}

resource "aws_cloudwatch_metric_alarm" "ga_cw_db_memory_alarm" {
  alarm_name                = "MySQL ${var.BRANCH_NAME} High Memory Utilization"
  comparison_operator       = "LessThanOrEqualToThreshold"
  alarm_actions             = [aws_sns_topic.ga_sns_topic.arn]
  insufficient_data_actions = []
  metric_name               = "FreeableMemory"
  namespace                 = "AWS/RDS"
  statistic                 = "Minimum"
  dimensions = {
    DBInstanceIdentifier  = aws_db_instance.ga_mysql.identifier
  }
  period                    = 300
  evaluation_periods        = 1
  datapoints_to_alarm       = 1
  threshold                 = floor(output.db_instance_memory_size * 0.90)
  treat_missing_data        = "missing"
  alarm_description         = "This metric monitors RDS ${var.BRANCH_NAME} memory utilization"
}

resource "aws_cloudwatch_metric_alarm" "ga_cw_db_drive_alarm" {
  alarm_name                = "MySQL ${var.BRANCH_NAME} drive usage reaching 90%"
  comparison_operator       = "LessThanThreshold"
  alarm_actions             = [aws_sns_topic.ga_sns_topic.arn]
  insufficient_data_actions = []
  metric_name               = "FreeStorageSpace"
  namespace                 = "AWS/RDS"
  statistic                 = "Minimum"
  dimensions = {
    DBInstanceIdentifier  = aws_db_instance.ga_mysql.identifier
  }
  period                    = 60
  evaluation_periods        = 1
  datapoints_to_alarm       = 1
  threshold                 = floor(output.db_allocated_storage * 0.90)
  treat_missing_data        = "missing"
  alarm_description         = "This metric monitors RDS ${var.BRANCH_NAME} drive usage reaching 90%"
}