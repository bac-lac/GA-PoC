resource "aws_route53_health_check" "ga_transfer_health_check" {
  fqdn                  = "transfert-transfer${local.HOSTNAME_SUFFIX}.bac-lac.gc.ca"
  port                  = 443
  type                  = "HTTPS"
  resource_path         = "/webclient/Login.xhtml"
  failure_threshold     = "3"
  request_interval      = "30"
  enable_sni            = true
  cloudwatch_alarm_name = aws_cloudwatch_metric_alarm.ga_cw_transfer_alarm.alarm_name
  tags = {
    Name = "GA Web Dev Client https://transfert-transfer${local.HOSTNAME_SUFFIX}.bac-lac.gc.ca"
  }
}