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
  container_definitions = templatefile("task-definitions/mft.tftpl", {
                                        ECR_IMAGE         = var.ECR_IMAGE,
                                        DB_USERNAME       = var.DB_USERNAME,
                                        DB_ADDRESS        = aws_db_instance.ga_mysql.address,
                                        DB_PASSWORD       = var.DB_PASSWORD,
                                        ADMIN_DB_USERNAME = var.ADMIN_DB_USERNAME,
                                        ADMIN_DB_PASSWORD = var.ADMIN_DB_PASSWORD,
                                        FORCE_REFRESH     = var.FORCE_REFRESH,
                                        MFT_NUMBER        = "1"
                                      })
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
    container_name      = "MFT-1"
    container_port      = 8000
  }
}

