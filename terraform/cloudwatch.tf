resource "aws_cloudwatch_log_group" "aws-waf-logs" {
  name = "aws-waf-logs-${var.BRANCH_NAME}"
  retention_in_days = 731
}