resource "aws_waf_sql_injection_match_set" "SQL_Injection_Rule_Match_Set" {
  name = "SQL_Injection_Rule_Match_Set"
  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"
    field_to_match {
      type = "QUERY_STRING"
    }
  }
  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"
    field_to_match {
      type = "QUERY_STRING"
    }
  }
  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"
    field_to_match {
      type = "URI"
    }
  }
  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"
    field_to_match {
      type = "URI"
    }
  }
  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"
    field_to_match {
      type = "BODY"
    }
  }
  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"
    field_to_match {
      type = "BODY"
    }
  }  
  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"
    field_to_match {
      type = "HEADER"
      data = "Cookie"
    }
  }
  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"
    field_to_match {
      type = "HEADER"
      data = "Cookie"
    }
  }
  sql_injection_match_tuples {
    text_transformation = "HTML_ENTITY_DECODE"
    field_to_match {
      type = "HEADER"
      data = "Authorization"
    }
  }
  sql_injection_match_tuples {
    text_transformation = "URL_DECODE"
    field_to_match {
      type = "HEADER"
      data = "Authorization"
    }
  }
}

resource "aws_waf_rule" "SQL_Injection_Rule" {
  name        = "SQL_Injection_Rule"
  metric_name = "SQL_Injection_Rule"
  predicates{
    data_id = "${aws_waf_sql_injection_match_set.SQL_Injection_Rule_Match_Set.id}"
    negated = false
    type = "SqlInjectionMatch"
  }
}

resource "aws_wafv2_web_acl" "ga_web_acl" {
  name        = "ga-web-acl-${var.BRANCH_NAME}"
  metric_name = "ga-web-acl-${var.BRANCH_NAME}"
  description = "Web ACL for GA."
  scope       = "REGIONAL"

  default_action {
    type = "ALLOW"
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

  rules {
    action {
      type = "BLOCK"
    }
    priority = 1
    rule_id  = "${aws_waf_rule.SQL_Injection_Rule.id}"
    type     = "REGULAR"
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