terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.45.0"
    }
  }

  backend "s3" {
    bucket      = "ga-poc-tfstate"
    region      = "ca-central-1"
    encrypt     = true
  }
}

provider "aws" {
  region  = "ca-central-1"
  assume_role {
    role_arn    = "arn:aws:iam::${var.ACCOUNT}:role/terraform-role"
  }
}

resource "aws_security_group" "ga_db_sg" {
  name        = "GA-DB-${var.BRANCH_NAME}-sg"
  description = "Allow traffic between ECS and DB"
  vpc_id      = var.VPC_ID
  tags = {
    Name = "GA-DB-${var.BRANCH_NAME}-sg"
  }
}

resource "aws_security_group" "ga_app_sg" {
  name        = "GA-App-${var.BRANCH_NAME}-sg"
  description = "Allow traffic between Load Balancer and ECS"
  vpc_id      = var.VPC_ID
  tags = {
    Name = "GA-App-${var.BRANCH_NAME}-sg"
  }
}

resource "aws_security_group" "ga_lb_sg" {
  name        = "GA-LB-${var.BRANCH_NAME}-sg"
  description = "Allow traffic to Load Balancer"
  vpc_id      = var.VPC_ID
  tags = {
    Name = "GA-LB-${var.BRANCH_NAME}-sg"
  }
}

resource "aws_security_group_rule" "allow_tcp_3306" {
  security_group_id         = aws_security_group.ga_db_sg.id
  source_security_group_id  = aws_security_group.ga_app_sg.id
  from_port                 = 3306
  protocol                  = "tcp"
  to_port                   = 3306
  type                      = "ingress"
}

resource "aws_security_group_rule" "allow_tcp_443" {
  security_group_id         = aws_security_group.ga_app_sg.id
  source_security_group_id  = aws_security_group.ga_lb_sg.id
  from_port                 = 443
  protocol                  = "tcp"
  to_port                   = 443
  type                      = "ingress"
}

resource "aws_security_group_rule" "allow_internet" {
  security_group_id         = aws_security_group.ga_lb_sg.id
  cidr_blocks               = ["0.0.0.0/0"]
  from_port                 = 443
  protocol                  = "tcp"
  to_port                   = 443
  type                      = "ingress"
}

data "aws_subnets" "data" {
  filter {
    name   = "tag:Name"
    values = ["*Data*"]
  }
}

data "aws_subnets" "web" {
  filter {
    name   = "tag:Name"
    values = ["*Web*"]
  }
}

resource "aws_db_subnet_group" "data" {
  name       = "ga-db-${var.BRANCH_NAME}-subnet-group"
  subnet_ids = data.aws_subnets.data.ids
}

resource "aws_db_instance" "ga_mysql" {
  allocated_storage         = 20
  db_name                   = format("GA%s", replace("${var.BRANCH_NAME}", "-", ""))
  engine                    = "mysql"
  engine_version            = "8.0.35"
  instance_class            = "db.t3.micro"
  username                  = var.ADMIN_DB_USERNAME
  password                  = var.ADMIN_DB_PASSWORD
  parameter_group_name      = "default.mysql8.0"
  skip_final_snapshot       = true
  storage_encrypted         = true
  vpc_security_group_ids    = [aws_security_group.ga_db_sg.id]
  db_subnet_group_name      = aws_db_subnet_group.data.name
}

resource "aws_efs_file_system" "ga_efs" {
  creation_token  = "ga-${var.BRANCH_NAME}-efs"
  encrypted       = true
  throughput_mode = "elastic"
  tags = {
    Name = "ga-${var.BRANCH_NAME}-efs"
  }
}

data "aws_subnets" "app" {
  filter {
    name   = "tag:Name"
    values = ["*App*"]
  }
}

resource "aws_efs_mount_target" "ga_efs_mount_target_1" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  security_groups = [aws_security_group.ga_app_sg.id]           
  subnet_id       = element(data.aws_subnets.app.ids, 1)
}

resource "aws_efs_mount_target" "ga_efs_mount_target_2" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  security_groups = [aws_security_group.ga_app_sg.id]
  subnet_id       = element(data.aws_subnets.app.ids, 2)
}

resource "aws_efs_access_point" "ga_ap_root" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  posix_user {
    gid = 992
    uid = 994
  }
  root_directory {
    creation_info {
      owner_gid   = 992
      owner_uid   = 994
      permissions = 777
    }
    path = "/"
  }
  tags = {
    Name = "root-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_userdata" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  posix_user {
    gid = 992
    uid = 994
  }
  root_directory {
    creation_info {
      owner_gid   = 992
      owner_uid   = 994
      permissions = 777
    }
    path = "/userdata"
  }
  tags = {
    Name = "userdata-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_sharedconfig" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  posix_user {
    gid = 992
    uid = 994
  }
  root_directory {
    creation_info {
      owner_gid   = 992
      owner_uid   = 994
      permissions = 777
    }
    path = "/sharedconfig"
  }
  tags = {
    Name = "sharedconfig-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_upgrader1" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  posix_user {
    gid = 992
    uid = 994
  }
  root_directory {
    creation_info {
      owner_gid   = 992
      owner_uid   = 994
      permissions = 777
    }
    path = "/upgrader1"
  }
  tags = {
    Name = "upgrader1-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_config1" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  posix_user {
    gid = 992
    uid = 994
  }
  root_directory {
    creation_info {
      owner_gid   = 992
      owner_uid   = 994
      permissions = 777
    }
    path = "/config1"
  }
  tags = {
    Name = "config1-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_tomcatserver1" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  posix_user {
    gid = 992
    uid = 994
  }
  root_directory {
    creation_info {
      owner_gid   = 992
      owner_uid   = 994
      permissions = 777
    }
    path = "/tomcatserver1"
  }
  tags = {
    Name = "tomcatserver1-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_tomcatlog1" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  posix_user {
    gid = 992
    uid = 994
  }
  root_directory {
    creation_info {
      owner_gid   = 992
      owner_uid   = 994
      permissions = 777
    }
    path = "/tomcatlog1"
  }
  tags = {
    Name = "tomcatlog1-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_ghttpsroot1" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  posix_user {
    gid = 992
    uid = 994
  }
  root_directory {
    creation_info {
      owner_gid   = 992
      owner_uid   = 994
      permissions = 777
    }
    path = "/ghttpsroot1"
  }
  tags = {
    Name = "ghttpsrootoot1-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_upgrader2" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  posix_user {
    gid = 992
    uid = 994
  }
  root_directory {
    creation_info {
      owner_gid   = 992
      owner_uid   = 994
      permissions = 777
    }
    path = "/upgrader2"
  }
  tags = {
    Name = "upgrader2-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_config2" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  posix_user {
    gid = 992
    uid = 994
  }
  root_directory {
    creation_info {
      owner_gid   = 992
      owner_uid   = 994
      permissions = 777
    }
    path = "/config2"
  }
  tags = {
    Name = "config2-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_tomcatserver2" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  posix_user {
    gid = 992
    uid = 994
  }
  root_directory {
    creation_info {
      owner_gid   = 992
      owner_uid   = 994
      permissions = 777
    }
    path = "/tomcatserver2"
  }
  tags = {
    Name = "tomcatserver2-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_tomcatlog2" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  posix_user {
    gid = 992
    uid = 994
  }
  root_directory {
    creation_info {
      owner_gid   = 992
      owner_uid   = 994
      permissions = 777
    }
    path = "/tomcatlog2"
  }
  tags = {
    Name = "tomcatlog2-${var.BRANCH_NAME}"
  }
}

resource "aws_efs_access_point" "ga_ap_ghttpsroot2" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  posix_user {
    gid = 992
    uid = 994
  }
  root_directory {
    creation_info {
      owner_gid   = 992
      owner_uid   = 994
      permissions = 777
    }
    path = "/ghttpsroot2"
  }
  tags = {
    Name = "ghttpsrootoot2-${var.BRANCH_NAME}"
  }
}

resource "aws_lb" "ga_lb" {
  name               = "ga-${var.BRANCH_NAME}-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ga_lb_sg.id]
  subnets            = data.aws_subnets.web.ids

  drop_invalid_header_fields = false
  enable_deletion_protection = false

  access_logs {
    bucket  = ""
    prefix  = "ga-${var.BRANCH_NAME}_lb_logs"
    enabled = false
  }

  tags = {
    Name = "ga-${var.BRANCH_NAME}-lb"
    Environment = "${var.ENV}"
  }
}

resource "aws_acm_certificate" "ga_certificate" {
  domain_name               = "${var.BRANCH_NAME}.ga-dev.bac-lac.ca"
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_zone" "ga_zone" {
  name = "${var.BRANCH_NAME}.ga-dev.bac-lac.ca"
}

resource "aws_route53_record" "ga_record_a" {
  zone_id = aws_route53_zone.ga_zone.zone_id
  name    = "${var.BRANCH_NAME}.ga-dev.bac-lac.ca"
  type    = "A"

  alias {
    name                   = aws_lb.ga_lb.dns_name
    zone_id                = aws_lb.ga_lb.zone_id
    evaluate_target_health = true
  }
}

data "aws_route53_zone" "ga_dev_zone" {
  name         = "ga-dev.bac-lac.ca"
  private_zone = false
}

resource "aws_route53_record" "ga_record_ns" {
  allow_overwrite = true
  zone_id = data.aws_route53_zone.ga_dev_zone.zone_id
  name    = "${var.BRANCH_NAME}.ga-dev.bac-lac.ca"
  type    = "NS"
  ttl     = 172800

  records = [
    aws_route53_zone.ga_zone.name_servers[0],
    aws_route53_zone.ga_zone.name_servers[1],
    aws_route53_zone.ga_zone.name_servers[2],
    aws_route53_zone.ga_zone.name_servers[3],
  ]
}

resource "aws_route53_record" "ga_record_cname" {
  for_each = {
    for dvo in aws_acm_certificate.ga_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.ga_zone.zone_id
}

resource "aws_acm_certificate_validation" "ga_certificate_validation" {
  certificate_arn         = aws_acm_certificate.ga_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.ga_record_cname : record.fqdn]
}

resource "aws_alb_listener" "ga_443" {
  load_balancer_arn = aws_lb.ga_lb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.ga_certificate.arn
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ga_tg.arn
  }
}

resource "aws_alb_listener" "http_80" {
  load_balancer_arn = aws_lb.ga_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_target_group" "ga_tg" {
  name     = "ga-${var.BRANCH_NAME}-tg"
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.VPC_ID
  health_check {
    path    = "/"
    matcher = "200,302"
  }
  stickiness {
    enabled = true
    type    = "lb_cookie"
  }
}

resource "aws_ecs_cluster" "ga_cluster" {
  name = "ga-cluster-${var.BRANCH_NAME}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_ecs_cluster_capacity_providers" "ga_cluster_capacity_providers" {
  cluster_name = aws_ecs_cluster.ga_cluster.name

  capacity_providers = ["FARGATE"]
}

resource "aws_ecs_task_definition" "ga_task_definition" {
  family                    = "ga-task-definition-${var.BRANCH_NAME}"
  container_definitions     = file("task-definitions/ga_task_definition.json")
  requires_compatibilities  = ["FARGATE"]
  network_mode              = "awsvpc"
  cpu                       = 1024
  memory                    = 3072
  execution_role_arn        = "arn:aws:iam::${var.ACCOUNT}:role/ecsTaskExecutionRole"
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  volume {
    name = "ga_ap_userdata"

    efs_volume_configuration {
      file_system_id        = aws_efs_file_system.ga_efs.id
      transit_encryption    = "ENABLED"
      authorization_config {
        access_point_id = aws_efs_access_point.ga_ap_userdata.id
      }
    }
  }
  volume {
  name = "ga_ap_sharedconfig"

  efs_volume_configuration {
    file_system_id          = aws_efs_file_system.ga_efs.id
    transit_encryption      = "ENABLED"
    authorization_config {
      access_point_id = aws_efs_access_point.ga_ap_sharedconfig.id
    }
  }
  }
  volume {
  name = "ga_ap_upgrader1"

  efs_volume_configuration {
    file_system_id          = aws_efs_file_system.ga_efs.id
    transit_encryption      = "ENABLED"
    authorization_config {
      access_point_id = aws_efs_access_point.ga_ap_upgrader1.id
    }
  }
  }
  volume {
  name = "ga_ap_config1"

  efs_volume_configuration {
    file_system_id          = aws_efs_file_system.ga_efs.id
    transit_encryption      = "ENABLED"
    authorization_config {
      access_point_id = aws_efs_access_point.ga_ap_config1.id
    }
  }
  }
  volume {
  name = "ga_ap_tomcatserver1"

  efs_volume_configuration {
    file_system_id          = aws_efs_file_system.ga_efs.id
    transit_encryption      = "ENABLED"
    authorization_config {
      access_point_id = aws_efs_access_point.ga_ap_tomcatserver1.id
    }
  }
  }
  volume {
  name = "ga_ap_tomcatlog1"

  efs_volume_configuration {
    file_system_id          = aws_efs_file_system.ga_efs.id
    transit_encryption      = "ENABLED"
    authorization_config {
      access_point_id = aws_efs_access_point.ga_ap_tomcatlog1.id
    }
  }
  }
   volume {
    name = "ga_ap_ghttpsroot1"

    efs_volume_configuration {
      file_system_id        = aws_efs_file_system.ga_efs.id
      transit_encryption    = "ENABLED"
      authorization_config {
        access_point_id = aws_efs_access_point.ga_ap_ghttpsroot1.id
      }
    }
  }
}
