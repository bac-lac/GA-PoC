resource "aws_cloudwatch_log_group" "aws-waf-logs" {
  name = "aws-waf-logs-${var.BRANCH_NAME}"
  skip_destroy = true
  tags = {
    Branch = "${var.BRANCH_NAME}"
  }
}