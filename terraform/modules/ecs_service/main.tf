resource "aws_ecs_task_definition" "ga_task_definition_mft" {
  family                    = "ga-task-definition-mft${var.MFT_NUMBER}-${var.BRANCH_NAME}"
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
      file_system_id        = var.ee_file_system_id
      transit_encryption    = "ENABLED"
      authorization_config {
        access_point_id = var.ga_ap_userdata_id
      }
    }
  }
  volume {
  name = "ga_ap_sharedconfig"

  efs_volume_configuration {
    file_system_id          = var.ee_file_system_id
    transit_encryption      = "ENABLED"
    authorization_config {
      access_point_id = var.ga_ap_sharedconfig_id
    }
  }
  }
  volume {
  name = "ga_ap_upgrader1"

  efs_volume_configuration {
    file_system_id          = var.ee_file_system_id
    transit_encryption      = "ENABLED"
    authorization_config {
      access_point_id = var.ga_ap_upgrader1_id
    }
  }
  }
  volume {
  name = "ga_ap_config1"

  efs_volume_configuration {
    file_system_id          = var.ee_file_system_id
    transit_encryption      = "ENABLED"
    authorization_config {
      access_point_id = var.ga_ap_config1_id
    }
  }
  }
  volume {
  name = "ga_ap_tomcatserver1"

  efs_volume_configuration {
    file_system_id          = var.ee_file_system_id
    transit_encryption      = "ENABLED"
    authorization_config {
      access_point_id = var.ga_ap_tomcatserver1_id
    }
  }
  }
  volume {
  name = "ga_ap_tomcatlog1"

  efs_volume_configuration {
    file_system_id          = var.ee_file_system_id
    transit_encryption      = "ENABLED"
    authorization_config {
      access_point_id = var.ga_ap_tomcatlog1_id
    }
  }
  }
   volume {
    name = "ga_ap_ghttpsroot1"

    efs_volume_configuration {
      file_system_id        = var.ee_file_system_id
      transit_encryption    = "ENABLED"
      authorization_config {
        access_point_id = var.ga_ap_ghttpsroot1_id
      }
    }
  }
  container_definitions = templatefile("task-definitions/mft.tftpl", {
                                        ECR_IMAGE         = var.ECR_IMAGE,
                                        DB_USERNAME       = var.DB_USERNAME,
                                        DB_ADDRESS        = var.db_address,
                                        DB_PASSWORD       = var.DB_PASSWORD,
                                        ADMIN_DB_USERNAME = var.ADMIN_DB_USERNAME,
                                        ADMIN_DB_PASSWORD = var.ADMIN_DB_PASSWORD,
                                        FORCE_REFRESH     = var.FORCE_REFRESH,
                                        MFT_NUMBER        = var.MFT_NUMBER
                                      })
}

resource "aws_ecs_service" "ga_service_mft" {
  name                  = "ga-service-mft${var.MFT_NUMBER}-${var.BRANCH_NAME}"
  cluster               = aws_ecs_cluster.ga_cluster.id
  task_definition       = aws_ecs_task_definition.ga_task_definition_mft.arn
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
    container_name      = "MFT-${var.MFT_NUMBER}"
    container_port      = 8000
  }
}