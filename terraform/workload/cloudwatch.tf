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
  threshold                 = floor(var.DB_INSTANCE_CLASS_MEMORY * 1024 * 1024 * 1024 * 0.10)
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
  threshold                 = floor(aws_db_instance.ga_mysql.allocated_storage * 1024 * 1024 * 1024 * 0.10)
  treat_missing_data        = "missing"
  alarm_description         = "This metric monitors RDS ${var.BRANCH_NAME} drive usage reaching 90%"
}

resource "aws_cloudwatch_metric_alarm" "ga_cw_ecs_cpu_alarm" {
  for_each                  = upper(var.MFT_CLUSTER) == "TRUE" ? toset(["1", "2"]) : toset(["1"])
  alarm_name                = "MFT-${each.key} ${var.BRANCH_NAME} High CPU Utilization"
  comparison_operator       = "GreaterThanThreshold"
  alarm_actions             = [aws_sns_topic.ga_sns_topic.arn]
  insufficient_data_actions = []
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/ECS"
  statistic                 = "Maximum"
  dimensions                = zipmap(["ServiceName", "ClusterName"], ["ga-service-mft${each.key}-${var.BRANCH_NAME}", aws_ecs_cluster.ga_cluster.name])
  period                    = 60
  evaluation_periods        = 1
  datapoints_to_alarm       = 1
  threshold                 = 80
  treat_missing_data        = "missing"
  alarm_description         = "This metric monitors MFT-${each.key} ${var.BRANCH_NAME} cpu utilization"
}

resource "aws_cloudwatch_metric_alarm" "ga_cw_ecs_memory_alarm" {
  for_each                  = upper(var.MFT_CLUSTER) == "TRUE" ? toset(["1", "2"]) : toset(["1"])
  alarm_name                = "MFT-${each.key} ${var.BRANCH_NAME} High Memory Utilization"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  alarm_actions             = [aws_sns_topic.ga_sns_topic.arn]
  insufficient_data_actions = []
  metric_name               = "MemoryUtilization"
  namespace                 = "AWS/ECS"
  statistic                 = "Maximum"
  dimensions                = zipmap(["ServiceName", "ClusterName"], ["ga-service-mft${each.key}-${var.BRANCH_NAME}", aws_ecs_cluster.ga_cluster.name])
  period                    = 300
  evaluation_periods        = 1
  datapoints_to_alarm       = 1
  threshold                 = 90
  treat_missing_data        = "missing"
  alarm_description         = "This metric monitors MFT-${each.key} ${var.BRANCH_NAME} memory utilization"
}