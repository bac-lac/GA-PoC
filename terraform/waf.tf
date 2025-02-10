resource "aws_wafv2_web_acl" "ga_web_acl" {
  name        = "ga-web-acl-${var.BRANCH_NAME}"
  description = "Web ACL for GA."
  scope       = "REGIONAL"

  default_action {
    allow {}
  }
  
  rule {
    name     = "DDOS-Prevention"
    priority = 0

    action {
      block {}
    }

    statement {
      RateBasedStatement {
        Limit = 100000
        EvaluationWindowSec = 300
        AggregateKeyType = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "DDOS_Prevention"
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "Rate-Limiting"
    priority = 1

    action {
      block {}
    }

    statement {
      rate_based_statement {
        aggregate_key_type = "IP"
        limit              = 500
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "Rate-Limiting"
      sampled_requests_enabled   = true
    }
  }

  tags = {
    Tag1 = "GA"
    Tag2 = "${var.BRANCH_NAME}"
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "ga_web_acl_${var.BRANCH_NAME}"
    sampled_requests_enabled   = true
  }
}

resource "aws_wafv2_web_acl_association" "web_acl_association_alb" {
  resource_arn = aws_lb.ga_alb.arn
  web_acl_arn  = aws_wafv2_web_acl.ga_web_acl.arn
}