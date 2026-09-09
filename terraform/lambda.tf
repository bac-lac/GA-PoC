data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../lambda/lambda_function.py"
  output_path = "../lambda/lambda_function.zip"
}

resource "aws_lambda_function" "eni_lambda" {
  function_name                   = "HandleENICreation-${var.ENV}"
  role                            = aws_iam_role.lambda_role.arn
  description                     = "Lambda function to handle ENI creation events and tag them with CBRID"
  handler                         = "lambda_function.lambda_handler"
  runtime                         = "python3.12"
  timeout                         = 30
  filename                        = data.archive_file.lambda_zip.output_path
  reserved_concurrent_executions  = 10
  source_code_hash                = data.archive_file.lambda_zip.output_base64sha256
  tracing_config {
    mode                          = "Active"
  }
}

resource "aws_cloudwatch_event_rule" "eni_create_rule" {
  name            = "ENICreateRule-${var.ENV}"
  description     = "Trigger Lambda on ENI creation"
  event_pattern   = jsonencode({
    source        = ["aws.ec2"]
    "detail-type" = ["AWS API Call via CloudTrail"]
    detail = {
      eventSource = ["ec2.amazonaws.com"]
      eventName   = ["CreateNetworkInterface"]
    }
  })
}

resource "aws_cloudwatch_event_target" "eni_lambda_target" {
  rule      = aws_cloudwatch_event_rule.eni_create_rule.name
  target_id = "ENILambdaTarget-${var.ENV}"
  arn       = aws_lambda_function.eni_lambda.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.eni_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.eni_create_rule.arn
}