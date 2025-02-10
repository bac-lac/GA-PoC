variable "rules" {
  type    = list
  default = [
    {
      name = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
      priority = 0
      managed_rule_group_statement_name = "AWSManagedRulesKnownBadInputsRuleSet"
      managed_rule_group_statement_vendor_name = "AWS"
      metric_name = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
    },
    {
      name = "AWS-AWSManagedRulesSQLiRuleSet"
      priority = 1
      managed_rule_group_statement_name = "AWS-AWSManagedRulesSQLiRuleSet"
      managed_rule_group_statement_vendor_name = "AWS"
      metric_name = "AWS-AWSManagedRulesSQLiRuleSet"
    }
  ]
}

resource "aws_wafv2_web_acl" "ga_web_acl" {
  name        = "ga-web-acl-${var.BRANCH_NAME}"
  description = "Web ACL for GA"
  scope       = "REGIONAL"

  default_action {
    allow {}
  }

  dynamic "rule" {
    for_each = toset(var.rules)

    content {
      name = rule.value.name
      priority = rule.value.priority
      override_action {
        none {}
      }
      statement {
        managed_rule_group_statement {
          name = rule.value.managed_rule_group_statement_name
          vendor_name = rule.value.managed_rule_group_statement_vendor_name
        }
      }
      visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = rule.value.metric_name
        sampled_requests_enabled   = true
      }
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "ga_web_acl_${var.BRANCH_NAME}"
    sampled_requests_enabled   = true
  }

  #checkov:skip=CKV_AWS_192: Ensure WAF prevents message lookup in Log4j2. This check is provided with AWS-AWSManagedRulesKnownBadInputsRuleSet.
}

data "aws_cloudwatch_log_group" "ga_cloudwatch" {
  name = "aws-waf-logs-alb"
}

resource "aws_wafv2_web_acl_logging_configuration" "ga_web_acl_logging" {
  log_destination_configs = [data.aws_cloudwatch_log_group.ga_cloudwatch.arn]
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