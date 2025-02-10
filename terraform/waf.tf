resource "aws_wafv2_web_acl" "ga_web_acl" {
  name        = "ga-web-acl-${var.BRANCH_NAME}"
  description = "Web ACL for GA."
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
    priority = 0

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }
  }

  rule {
    name     = "AWS-AWSManagedRulesSQLiRuleSet"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "AWS-AWSManagedRulesSQLiRuleSet"
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

data "aws_cloudwatch_log_group" "ga_cloudwatch" {
  name = "/ecs/ga-td"
}

resource "aws_wafv2_web_acl_logging_configuration" "ga_web_acl_logging" {
  log_destination_configs = data.aws_cloudwatch_log_group.ga_cloudwatch.arn
  resource_arn            = aws_wafv2_web_acl.ga_web_acl.arn
  redacted_fields {
    single_header {
      name = "user-agent"
    }
  }
}

resource "aws_wafv2_web_acl_association" "web_acl_association_alb" {
  resource_arn = aws_lb.ga_alb.arn
  web_acl_arn  = aws_wafv2_web_acl.ga_web_acl.arn
}