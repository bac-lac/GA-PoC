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
  name       = "ga-db-subnet-group-${var.BRANCH_NAME}"
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
  vpc_security_group_ids    = [data.aws_security_group.data.id]
  db_subnet_group_name      = aws_db_subnet_group.data.name
}

resource "aws_efs_file_system" "ga_efs" {
  creation_token  = "ga-efs-${var.BRANCH_NAME}"
  encrypted       = true
  throughput_mode = "elastic"
  tags = {
    Name = "ga-efs-${var.BRANCH_NAME}"
  }
}

data "aws_subnets" "app" {
  filter {
    name   = "tag:Name"
    values = ["*App*"]
  }
}

data "aws_security_group" "app" {
  filter {
    name   = "tag:Name"
    values = ["App"]
  }
}

data "aws_security_group" "web" {
  filter {
    name   = "tag:Name"
    values = ["Web"]
  }
}

data "aws_security_group" "data" {
  filter {
    name   = "tag:Name"
    values = ["Data"]
  }
}

resource "aws_efs_mount_target" "ga_efs_mount_target_1" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  security_groups = [data.aws_security_group.app.id]           
  subnet_id       = element(data.aws_subnets.app.ids, 1)
}

resource "aws_efs_mount_target" "ga_efs_mount_target_2" {
  file_system_id  = aws_efs_file_system.ga_efs.id
  security_groups = [data.aws_security_group.app.id]
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

data "aws_lb" "core_lb"{
  name = "core-${var.ENV}-alb"
}

data "aws_lb_listener" "https" {
  load_balancer_arn = data.aws_lb.core_lb.arn
  port              = 443
}

resource "aws_lb_listener_rule" "https_rule" {
  listener_arn        = data.aws_lb_listener.https.arn

  action {
    type              = "forward"
    target_group_arn  = aws_lb_target_group.ga_tg.arn
  }

  condition {
    host_header {
      values          = [var.BRANCH_NAME == "main" ? "ga.${var.ENV}.bac-lac.ca" : "${var.BRANCH_NAME}.ga.dev.bac-lac.ca"]
    }
  }
}

resource "aws_lb_target_group" "ga_tg" {
  name        = "ga-tg-${var.BRANCH_NAME}"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.VPC_ID
  health_check {
  path        = "/"
    matcher   = "200,302"
  }
  stickiness {
    enabled   = true
    type      = "lb_cookie"
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
  container_definitions = jsonencode([
    {
        "name": "mft1",
        "image": "${var.ECR_IMAGE}",
        "cpu": 0,
        "portMappings": [
            {
                "name": "mft1-8000-tcp",
                "containerPort": 8000,
                "protocol": "tcp",
                "appProtocol": "http"
            }
        ],
        "essential": true,
        "environment": [
            {
                "name": "SYSTEM_NAME",
                "value": "MFT-1"
            },
            {
                "name": "DB_USERNAME",
                "value": "${var.DB_USERNAME}"
            },
            {
                "name": "DB_ADDRESS",
                "value": "${aws_db_instance.ga_mysql.address}"
            },
            {
                "name": "DB_PASSWORD",
                "value": "${var.DB_PASSWORD}"
            },
            {
                "name": "ADMIN_DB_USERNAME",
                "value": "${var.ADMIN_DB_USERNAME}"
            },
            {
                "name": "ADMIN_DB_PASSWORD",
                "value": "${var.ADMIN_DB_PASSWORD}"
            },
            {
                "name": "MFT_CLUSTER",
                "value": "FALSE"
            }
        ],
        "mountPoints": [
            {
                "sourceVolume": "ga_ap_userdata",
                "containerPath": "/opt/HelpSystems/GoAnywhere/userdata/",
                "readOnly": false
            },
            {
                "sourceVolume": "ga_ap_sharedconfig",
                "containerPath": "/etc/HelpSystems/GoAnywhere/sharedconfig/",
                "readOnly": false
            },
            {
                "sourceVolume": "ga_ap_upgrader1",
                "containerPath": "/opt/HelpSystems/GoAnywhere/upgrader/",
                "readOnly": false
            },
            {
                "sourceVolume": "ga_ap_config1",
                "containerPath": "/etc/HelpSystems/GoAnywhere/config/",
                "readOnly": false
            },
            {
                "sourceVolume": "ga_ap_tomcatserver1",
                "containerPath": "/etc/HelpSystems/GoAnywhere/tomcat/",
                "readOnly": false
            },
            {
                "sourceVolume": "ga_ap_tomcatlog1",
                "containerPath": "/opt/HelpSystems/GoAnywhere/tomcat/logs/",
                "readOnly": false
            },
            {
                "sourceVolume": "ga_ap_ghttpsroot1",
                "containerPath": "/opt/HelpSystems/GoAnywhere/ghttpsroot/custom/",
                "readOnly": false
            }
        ],
        "volumesFrom": [],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-create-group": "true",
                "awslogs-group": "/ecs/ga-td",
                "awslogs-region": "ca-central-1",
                "awslogs-stream-prefix": "ecs"
            }
        },
        "healthCheck": {
            "command": [
                "CMD-SHELL",
                "curl -f http://localhost:8000/ || exit 1"
            ],
            "interval": 30,
            "timeout": 5,
            "retries": 3,
            "startPeriod": 120
        },
        "systemControls": []
    }
])
}

resource "aws_ecs_service" "ga_service" {
  name                  = "ga-service-${var.BRANCH_NAME}"
  cluster               = aws_ecs_cluster.ga_cluster.id
  task_definition       = aws_ecs_task_definition.ga_task_definition.arn
  launch_type           = "FARGATE"
  platform_version      = "LATEST"
  scheduling_strategy   = "REPLICA"
  desired_count         = 1
  network_configuration {
    subnets             = data.aws_subnets.app.ids
    security_groups     = [data.aws_security_group.app.id]
    assign_public_ip    = false
  }
  load_balancer {
    target_group_arn    = aws_lb_target_group.ga_tg.arn
    container_name      = "mft1"
    container_port      = 8000
  }

}