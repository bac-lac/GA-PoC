resource "aws_sns_topic" "ga_sns_topic" {
  name = "GoAnywhere_Alarms_Topic"
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
  endpoint  = "test@bac-lac.gc.ca"
}

resource "aws_cloudwatch_metric_alarm" "ga_cw_db_cpu_alarm" {
  alarm_name                = "MySQL High CPU Utilization"
  comparison_operator       = "GreaterThanThreshold"
  ActionsEnabled            = true
  OKActions                 = []
  AlarmActions              = [aws_sns_topic.ga_sns_topic.arn]
  insufficient_data_actions = []
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  statistic                 = "Maximum"
  dimensions = {
    Name    = "DBInstanceIdentifier"
    Value   = "issue-198"
  }
  period                    = 60
  evaluation_periods        = 1
  DatapointsToAlarm         = 1
  threshold                 = 80
  TreatMissingData          = missing
  alarm_description         = "This metric monitors RDS cpu utilization"
}