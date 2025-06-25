data "aws_db_instance" "ga_db_instance" {
  db_instance_identifier = "ga_mysql"
}

output "db_total_memory" {
  value = data.aws_db_instance.ga_db_instance.total_memory
}

output "db_allocated_storage" {
  value = data.aws_db_instance.ga_db_instance.allocated_storage
}

resource "aws_sns_topic" "ga_sns_topic" {
  name = "GoAnywhere_${var.BRANCH_NAME}_Alarms_Topic"
  kms_master_key_id = "alias/aws/sns"
  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultRequestPolicy": {
      "headerContentType": "text/plain; charset=UTF-8"
    }
  }
}
EOF
}

resource "aws_sns_topic_subscription" "ga_sns_topic_subscription" {
  topic_arn = aws_sns_topic.ga_sns_topic.arn
  protocol  = "email"
  endpoint  = "${var.CLOUDWATCH_EMAIL}"
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
    DBInstanceIdentifier  = "ga-db-${var.BRANCH_NAME}"
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
    DBInstanceIdentifier  = "ga-db-${var.BRANCH_NAME}"
  }
  period                    = 300
  evaluation_periods        = 1
  datapoints_to_alarm       = 1
  threshold                 = Math.round(output.total_memory * 0.90)
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
    DBInstanceIdentifier  = "ga-db-${var.BRANCH_NAME}"
  }
  period                    = 60
  evaluation_periods        = 1
  datapoints_to_alarm       = 1
  threshold                 = Math.round(output.db_allocated_storage * 0.90)
  treat_missing_data        = "missing"
  alarm_description         = "This metric monitors RDS ${var.BRANCH_NAME} drive usage reaching 90%"
}