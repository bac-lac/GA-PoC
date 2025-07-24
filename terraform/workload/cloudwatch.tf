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
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  threshold                 = 90
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
  period                    = 60
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
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
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
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
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  threshold                 = 90
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
  period                    = 60
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  threshold                 = 90
  treat_missing_data        = "missing"
  alarm_description         = "This metric monitors MFT-${each.key} ${var.BRANCH_NAME} memory utilization"
}

resource "aws_cloudwatch_metric_alarm" "ga_cw_ecs_drive_alarm" {
  for_each                  = upper(var.MFT_CLUSTER) == "TRUE" ? toset(["1", "2"]) : toset(["1"])
  alarm_name                = "MFT-${each.key} ${var.BRANCH_NAME} drive usage reaching 90%"
  comparison_operator       = "GreaterThanThreshold"
  alarm_actions             = [aws_sns_topic.ga_sns_topic.arn]
  insufficient_data_actions = []
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  threshold                 = 90
  treat_missing_data        = "missing"
  alarm_description         = "This metric monitors MFT-${each.key} ${var.BRANCH_NAME} drive utilization"

  metric_query {
    id          = "e1"
    expression  = "m1*100/m2"
    label       = "Storage used in %"
    return_data = "true"
  }

  metric_query {
    id = "m1"
    return_data = "false"

    metric {
      metric_name = "EphemeralStorageUtilized"
      namespace   = "ECS/ContainerInsights"
      period      = 60
      stat        = "Maximum"
      dimensions  = zipmap(["ServiceName", "ClusterName"], ["ga-service-mft${each.key}-${var.BRANCH_NAME}", aws_ecs_cluster.ga_cluster.name])
    }
  }

  metric_query {
    id = "m2"
    return_data = "false"

    metric {
      metric_name = "EphemeralStorageReserved"
      namespace   = "ECS/ContainerInsights"
      period      = 60
      stat        = "Maximum"
      dimensions  = zipmap(["ServiceName", "ClusterName"], ["ga-service-mft${each.key}-${var.BRANCH_NAME}", aws_ecs_cluster.ga_cluster.name])
    }
  }

}

resource "aws_cloudwatch_metric_alarm" "ga_cw_nlb_22_alarm" {
  alarm_name                = "NLB port 22 ${var.BRANCH_NAME} Healthy Host"
  comparison_operator       = "LessThanThreshold"
  alarm_actions             = [aws_sns_topic.ga_sns_topic.arn]
  insufficient_data_actions = []
  metric_name               = "HealthyHostCount"
  namespace                 = "AWS/NetworkELB"
  statistic                 = "Minimum"
  dimensions                = zipmap(["TargetGroup", "LoadBalancer"], [aws_lb_target_group.ga_tg_22.arn_suffix, data.aws_lb.ga_nlb.arn_suffix])
  period                    = 60
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  threshold                 = 1
  treat_missing_data        = "missing"
  alarm_description         = "This metric monitors NLB port 22 ${var.BRANCH_NAME} Healthy Host"
}

resource "aws_cloudwatch_metric_alarm" "ga_cw_alb_443_alarm" {
  alarm_name                = "ALB port 443 ${var.BRANCH_NAME} Healthy Host"
  comparison_operator       = "LessThanThreshold"
  alarm_actions             = [aws_sns_topic.ga_sns_topic.arn]
  insufficient_data_actions = []
  metric_name               = "HealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  statistic                 = "Minimum"
  dimensions                = zipmap(["TargetGroup", "LoadBalancer"], [aws_lb_target_group.ga_tg_443.arn_suffix, data.aws_lb.ga_alb.arn_suffix])
  period                    = 60
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  threshold                 = 1
  treat_missing_data        = "missing"
  alarm_description         = "This metric monitors ALB port 443 ${var.BRANCH_NAME} Healthy Host"
}

resource "aws_cloudwatch_metric_alarm" "ga_cw_alb_8443_alarm" {
  alarm_name                = "ALB port 8443 ${var.BRANCH_NAME} Healthy Host"
  comparison_operator       = "LessThanThreshold"
  alarm_actions             = [aws_sns_topic.ga_sns_topic.arn]
  insufficient_data_actions = []
  metric_name               = "HealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  statistic                 = "Minimum"
  dimensions                = zipmap(["TargetGroup", "LoadBalancer"], [aws_lb_target_group.ga_tg_8443.arn_suffix, data.aws_lb.ga_alb.arn_suffix])
  period                    = 60
  evaluation_periods        = 5
  datapoints_to_alarm       = 5
  threshold                 = 1
  treat_missing_data        = "missing"
  alarm_description         = "This metric monitors ALB port 8443 ${var.BRANCH_NAME} Healthy Host"
}