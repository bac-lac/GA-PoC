resource "aws_ecs_task_definition" "ga_task_definition_mft" {
  family                    = "ga-task-definition-mft${var.MOD_MFT_NUMBER}-${var.MOD_BRANCH_NAME}"
  requires_compatibilities  = ["FARGATE"]
  network_mode              = "awsvpc"
  cpu                       = var.MOD_TASK_DEFINITION_CPU
  memory                    = var.MOD_TASK_DEFINITION_MEMORY
  execution_role_arn        = var.MOD_ECS_ROLE_ARN
  task_role_arn             = var.MOD_ECS_TASK_ROLE_ARN
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
  dynamic "volume" {
    for_each = tomap({
      ga_ap_userdata      = var.MOD_GA_AP_USERDATA_ID
      ga_ap_sharedconfig  = var.MOD_GA_AP_SHAREDCONFIG_ID
      ga_ap_upgrader      = var.MOD_GA_AP_UPGRADER_ID
      ga_ap_config        = var.MOD_GA_AP_CONFIG_ID
      ga_ap_tomcatserver  = var.MOD_GA_AP_TOMCATSERVER_ID
      ga_ap_tomcatlog     = var.MOD_GA_AP_TOMCATLOG_ID
      ga_ap_ghttpsroot    = var.MOD_GA_AP_GHTTPSROOT_ID
    })
    content {
      name = volume.key

      efs_volume_configuration {
        file_system_id        = var.MOD_FILE_SYSTEM_ID
        transit_encryption    = "ENABLED"
        authorization_config {
          access_point_id = volume.value
        }
      }
    }
  }
  container_definitions = templatefile("task-definitions/mft.tftpl", {
                                        ECR_IMAGE         = var.MOD_ECR_IMAGE,
                                        BRANCH_NAME       = var.MOD_BRANCH_NAME,
                                        DB_USERNAME       = var.MOD_DB_USERNAME,
                                        DB_ADDRESS        = var.MOD_DB_ADDRESS,
                                        DB_PASSWORD       = var.MOD_DB_PASSWORD,
                                        ADMIN_DB_USERNAME = var.MOD_ADMIN_DB_USERNAME,
                                        ADMIN_DB_PASSWORD = var.MOD_ADMIN_DB_PASSWORD,
                                        FORCE_REFRESH     = var.MOD_FORCE_REFRESH,
                                        FRESH_INSTALL     = var.MOD_FRESH_INSTALL,
                                        MFT_NUMBER        = var.MOD_MFT_NUMBER,
                                        MFT_CLUSTER       = var.MOD_CLUSTER
                                      })
}

resource "aws_ecs_service" "ga_service_mft" {
  name                  = "ga-service-mft${var.MOD_MFT_NUMBER}-${var.MOD_BRANCH_NAME}"
  cluster               = var.MOD_CLUSTER_ID
  task_definition       = aws_ecs_task_definition.ga_task_definition_mft.arn
  launch_type           = "FARGATE"
  platform_version      = "LATEST"
  force_new_deployment  = true
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
  load_balancer {
    target_group_arn    = var.MOD_TARGET_GROUP_8443_ARN
    container_name      = "MFT-${var.MOD_MFT_NUMBER}"
    container_port      = 8443
  }
  load_balancer {
    target_group_arn    = var.MOD_TARGET_GROUP_22_ARN
    container_name      = "MFT-${var.MOD_MFT_NUMBER}"
    container_port      = 8022
  }
  enable_execute_command = true
}