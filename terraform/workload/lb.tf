data "aws_lb" "ga_alb"{
  name = "${var.ALB_NAME}"
}

resource "aws_lb_listener" "https" {
  load_balancer_arn   = data.aws_lb.ga_alb.arn
  port                = "443"
  protocol            = "HTTPS"
  ssl_policy          = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn     = aws_acm_certificate.baclacgcca.arn
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
      values          = [var.BRANCH_NAME == "main" ? "goanywhere-${var.ENV}.bac-lac.gc.ca" : "${var.BRANCH_NAME}.goanywhere-dev.bac-lac.gc.ca"]
    }
  }
  tags = {
    Name = "Admin-${var.BRANCH_ENV}"
  }
}

resource "aws_lb_listener_rule" "admin_internal_rule" {
  listener_arn        = aws_lb_listener.https.arn
  action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.ga_tg_443.arn
  }
  condition {
    host_header {
      values          = [var.BRANCH_NAME == "main" ? "ga-${var.ENV}-internal.bac-lac.gc.ca" : "${var.BRANCH_NAME}.ga-dev-internal.bac-lac.gc.ca"]
    }
  }
  tags = {
    Name = "Admin-Internal-${var.BRANCH_ENV}"
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
      values          = [var.BRANCH_NAME == "main" ? "transfert-transfer-${var.ENV}.bac-lac.gc.ca" : "${var.BRANCH_NAME}.transfert-transfer-dev.bac-lac.gc.ca"]
    }
  }
  tags = {
    Name = "Web-Client-${var.BRANCH_ENV}"
  }
}

resource "aws_lb_target_group" "ga_tg_443" {
  name        = "ga-tg-${var.BRANCH_ENV}-443"
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
    Name = "Admin-${var.BRANCH_ENV}"
  }
}

resource "aws_lb_target_group" "ga_tg_8443" {
  name        = "ga-tg-${var.BRANCH_ENV}-8443"
  port        = 8443
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id
  health_check {
    path      = "/"
    matcher   = "200,302"
    port      = var.BRANCH_NAME == "main" ? 8443 : 8001
    protocol  = "HTTPS"
  }
  stickiness {
    enabled   = true
    type      = "lb_cookie"
  }
  tags = {
    Name = "Web-client-${var.BRANCH_ENV}"
  }
}

data "aws_lb" "ga_nlb"{
  name = "${var.NLB_NAME}"
}

resource "aws_lb_listener" "sftp" {
  load_balancer_arn   = data.aws_lb.ga_nlb.arn
  port                = "22"
  protocol            = "TCP"
  default_action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.ga_tg_22.arn
  }
  tags = {
    Name = "SFTP-${var.BRANCH_ENV}"
  }
}

resource "aws_lb_target_group" "ga_tg_22" {
  name        = "ga-tg-${var.BRANCH_ENV}-22"
  port        = 22
  protocol    = "TCP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id
  health_check {
    port      = var.BRANCH_NAME == "main" ? 8022 : 8001
    protocol  = "TCP"
  }
  tags = {
    Name = "SFTP-${var.BRANCH_ENV}"
  }
}