resource "aws_ecs_task_definition" "ga_task_definition_mft" {
  family                    = "ga-task-definition-mft${var.MOD_MFT_NUMBER}-${var.MOD_BRANCH_NAME}"
  requires_compatibilities  = ["FARGATE"]
  network_mode              = "awsvpc"
  cpu                       = 1024
  memory                    = 3072
  execution_role_arn        = "arn:aws:iam::${var.MOD_ACCOUNT}:role/ecsTaskExecutionRole"
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  volume {
    name = "ga_ap_userdata"

    efs_volume_configuration {
      file_system_id        = var.MOD_FILE_SYSTEM_ID
      transit_encryption    = "ENABLED"
      authorization_config {
        access_point_id = var.MOD_GA_AP_USERDATA_ID
      }
    }
  }
  volume {
  name = "ga_ap_sharedconfig"

  efs_volume_configuration {
    file_system_id          = var.MOD_FILE_SYSTEM_ID
    transit_encryption      = "ENABLED"
    authorization_config {
      access_point_id = var.MOD_GA_AP_SHAREDCONFIG_ID
    }
  }
  }
  volume {
  name = "ga_ap_upgrader1"

  efs_volume_configuration {
    file_system_id          = var.MOD_FILE_SYSTEM_ID
    transit_encryption      = "ENABLED"
    authorization_config {
      access_point_id = var.MOD_GA_AP_UPGRADER1_ID
    }
  }
  }
  volume {
  name = "ga_ap_config1"

  efs_volume_configuration {
    file_system_id          = var.MOD_FILE_SYSTEM_ID
    transit_encryption      = "ENABLED"
    authorization_config {
      access_point_id = var.MOD_GA_AP_CONFIG1_ID
    }
  }
  }
  volume {
  name = "ga_ap_tomcatserver1"

  efs_volume_configuration {
    file_system_id          = var.MOD_FILE_SYSTEM_ID
    transit_encryption      = "ENABLED"
    authorization_config {
      access_point_id = var.MOD_GA_AP_TOMCATSERVER1_ID
    }
  }
  }
  volume {
  name = "ga_ap_tomcatlog1"

  efs_volume_configuration {
    file_system_id          = var.MOD_FILE_SYSTEM_ID
    transit_encryption      = "ENABLED"
    authorization_config {
      access_point_id = var.MOD_GA_AP_TOMCATLOG1_ID
    }
  }
  }
   volume {
    name = "ga_ap_ghttpsroot1"

    efs_volume_configuration {
      file_system_id        = var.MOD_FILE_SYSTEM_ID
      transit_encryption    = "ENABLED"
      authorization_config {
        access_point_id = var.MOD_GA_AP_GHTTPSROOT1_ID
      }
    }
  }
  container_definitions = templatefile("task-definitions/mft.tftpl", {
                                        ECR_IMAGE         = var.MOD_ECR_IMAGE,
                                        DB_USERNAME       = var.MOD_DB_USERNAME,
                                        DB_ADDRESS        = var.MOD_DB_ADDRESS,
                                        DB_PASSWORD       = var.MOD_DB_PASSWORD,
                                        ADMIN_DB_USERNAME = var.MOD_ADMIN_DB_USERNAME,
                                        ADMIN_DB_PASSWORD = var.MOD_ADMIN_DB_PASSWORD,
                                        FORCE_REFRESH     = var.MOD_FORCE_REFRESH,
                                        MFT_NUMBER        = var.MOD_MFT_NUMBER
                                      })
}

resource "aws_ecs_service" "ga_service_mft" {
  name                  = "ga-service-mft${var.MOD_MFT_NUMBER}-${var.MOD_BRANCH_NAME}"
  cluster               = var.MOD_CLUSTER_ID
  task_definition       = aws_ecs_task_definition.ga_task_definition_mft.arn
  launch_type           = "FARGATE"
  platform_version      = "LATEST"
  scheduling_strategy   = "REPLICA"
  desired_count         = 1
  network_configuration {
    subnets             = var.MOD_SUBNETS
    security_groups     = [var.MOD_SECURITY_GROUP_ID]
    assign_public_ip    = false
  }
  load_balancer {
    target_group_arn    = var.MOD_TARGET_GROUP_ARN
    container_name      = "MFT-${var.MOD_MFT_NUMBER}"
    container_port      = 8000
  }
}