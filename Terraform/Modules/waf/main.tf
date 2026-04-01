resource "aws_wafv2_web_acl" "waf" {
  name  = "waf"
  scope = "REGIONAL"

  default_action {
    allow {}
  }

  # Managed rules
  rule {
    name     = "managed-rules"
    priority = 1

    override_action {
      none {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "managed"
      sampled_requests_enabled   = true
    }
  }

  # Rate limiting
  rule {
    name     = "rate-limit"
    priority = 2

    action {
      block {}
    }

    statement {
      rate_based_statement {
        limit              = 1000
        aggregate_key_type = "IP"
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "rate"
      sampled_requests_enabled   = true
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "waf"
    sampled_requests_enabled   = true
  }
}

# Associate WAF with ALB
resource "aws_wafv2_web_acl_association" "assoc" {
  resource_arn = var.alb
  web_acl_arn  = aws_wafv2_web_acl.waf.arn
}