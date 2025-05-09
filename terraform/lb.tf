data "aws_lb" "ga_alb"{
  name = "${var.ALB_NAME}"
}

resource "aws_lb_listener" "https" {
  load_balancer_arn   = data.aws_lb.ga_alb.arn
  port                = var.BRANCH_NAME == "main" ? "443" : "444"
  protocol            = "HTTPS"
  ssl_policy          = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn     = aws_acm_certificate.baclacca.arn
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Default response content"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener_rule" "admin_rule" {
  listener_arn        = aws_lb_listener.https.arn
  action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.ga_tg_443.arn
  }
  condition {
    host_header {
      values          = [var.BRANCH_NAME == "main" ? "${var.ENV}.ga.bac-lac.ca" : "${var.BRANCH_NAME}.dev.ga.bac-lac.ca"]
    }
  }
  tags = {
    Name = "Admin-${var.BRANCH_NAME}"
  }
}

resource "aws_lb_listener_rule" "web_client_rule" {
  listener_arn        = aws_lb_listener.https.arn
  action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.ga_tg_8443.arn
  }
  condition {
    host_header {
      values          = [var.BRANCH_NAME == "main" ? "transfer.${var.ENV}.ga.bac-lac.ca" : "transfer.${var.BRANCH_NAME}.dev.ga.bac-lac.ca"]
    }
  }
  tags = {
    Name = "Web-Client-${var.BRANCH_NAME}"
  }
}

resource "aws_lb_target_group" "ga_tg_443" {
  name        = "ga-tg-${var.BRANCH_NAME}-443"
  port        = 443
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id
  health_check {
    path      = "/"
    matcher   = "200,302"
    port      = 8001
    protocol  = "HTTPS"
  }
  stickiness {
    enabled   = true
    type      = "lb_cookie"
  }
  tags = {
    Name = "Admin-${var.BRANCH_NAME}"
  }
}

resource "aws_lb_target_group" "ga_tg_8443" {
  name        = "ga-tg-${var.BRANCH_NAME}-8443"
  port        = 8443
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id
  health_check {
    path      = "/"
    matcher   = "200,302"
    port      = 8443
    protocol  = "HTTPS"
  }
  stickiness {
    enabled   = true
    type      = "lb_cookie"
  }
  tags = {
    Name = "Web-client-${var.BRANCH_NAME}"
  }
}

data "aws_lb" "ga_nlb"{
  name = "${var.NLB_NAME}"
}

resource "aws_lb_listener" "sftp" {
  load_balancer_arn   = data.aws_lb.ga_nlb.arn
  port                = var.BRANCH_NAME == "main" ? "22" : "8022"
  protocol            = "TCP"
  default_action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.ga_tg_22.arn
  }
  tags = {
    Name = "SFTP-${var.BRANCH_NAME}"
  }
}

resource "aws_lb_target_group" "ga_tg_22" {
  name        = "ga-tg-${var.BRANCH_NAME}-22"
  port        = 22
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id
  health_check {
    port      = 8022
    protocol  = "TCP"
  }
  tags = {
    Name = "SFTP-${var.BRANCH_NAME}"
  }
}