resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  inline_policy {
    name   = "create_eni_policy"
    policy = data.aws_iam_policy_document.create_eni_policy.json
  }

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

data "aws_iam_policy_document" "create_eni_policy" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:CreateTags"]
    resources = ["arn:aws:ec2:*:${var.ACCOUNT}:network-interface/*"]
  }
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "eni_lambda" {
  function_name = "HandleENICreation"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.handler"
  runtime       = "python3.9"

  filename         = "lambda.zip"
  source_code_hash = filebase64sha256("lambda.zip")
}

resource "aws_cloudwatch_event_rule" "eni_create_rule" {
  name        = "ENICreateRule"
  description = "Trigger Lambda on ENI creation"
  event_pattern = jsonencode({
    source      = ["aws.ec2"]
    "detail-type" = ["AWS API Call via CloudTrail"]
    detail = {
      eventSource = ["ec2.amazonaws.com"]
      eventName   = ["CreateNetworkInterface"]
    }
  })
}

resource "aws_cloudwatch_event_target" "eni_lambda_target" {
  rule      = aws_cloudwatch_event_rule.eni_create_rule.name
  target_id = "ENILambdaTarget"
  arn       = aws_lambda_function.eni_lambda.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.eni_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.eni_create_rule.arn
}
