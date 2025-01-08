data "aws_lb" "core_lb"{
  name = "core-${var.ENV}-alb"
}

data "aws_lb_listener" "https" {
  load_balancer_arn = data.aws_lb.core_lb.arn
  port              = 443
}

data "aws_lb_listener" "http" {
  load_balancer_arn = data.aws_lb.core_lb.arn
  port              = 80
}

resource "aws_lb_listener_rule" "https_rule" {
  listener_arn        = data.aws_lb_listener.https.arn

  action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.ga_tg.arn
  }

  condition {
    host_header {
      values          = [var.BRANCH_NAME == "main" ? "${var.ENV}.ga.bac-lac.ca" : "${var.BRANCH_NAME}.dev.ga.bac-lac.ca"]
    }
  }
}

resource "aws_lb_listener_rule" "http_rule" {
  listener_arn        = data.aws_lb_listener.http.arn

  action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.ga_tg_8000.arn
  }

  condition {
    host_header {
      values          = [var.BRANCH_NAME == "main" ? "${var.ENV}.ga.bac-lac.ca" : "${var.BRANCH_NAME}.dev.ga.bac-lac.ca"]
    }
  }
}

resource "aws_lb_target_group" "ga_tg" {
  name        = "ga-tg-${var.BRANCH_NAME}"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id
  health_check {
    path      = "/"
    matcher   = "200,302"
  }
  stickiness {
    enabled   = true
    type      = "lb_cookie"
  }
}

resource "aws_lb_target_group" "ga_tg_8000" {
  name        = "ga-tg-${var.BRANCH_NAME}-8000"
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_vpc.vpc.id
  health_check {
    path      = "/"
    matcher   = "200,302"
  }
  stickiness {
    enabled   = true
    type      = "lb_cookie"
  }
}

