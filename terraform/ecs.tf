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

module "ecs_service" {
  source                      = "./modules/ecs_service/"
  for_each                    = var.MFT_CLUSTER == "TRUE" ? toset(["1", "2"]) : toset(["1"])
  MOD_MFT_NUMBER              = each.key
  MOD_CLUSTER                 = var.MFT_CLUSTER
  MOD_FILE_SYSTEM_ID          = aws_efs_file_system.ga_efs.id
  MOD_GA_AP_USERDATA_ID       = aws_efs_access_point.ga_ap["userdata"].id
  MOD_GA_AP_SHAREDCONFIG_ID   = aws_efs_access_point.ga_ap["sharedconfig"].id
  MOD_GA_AP_UPGRADER_ID       = aws_efs_access_point.ga_ap["upgrader${each.key}"].id
  MOD_GA_AP_CONFIG_ID         = aws_efs_access_point.ga_ap["config${each.key}"].id
  MOD_GA_AP_TOMCATSERVER_ID   = aws_efs_access_point.ga_ap["tomcatserver${each.key}"].id
  MOD_GA_AP_TOMCATLOG_ID      = aws_efs_access_point.ga_ap["tomcatlog${each.key}"].id
  MOD_GA_AP_GHTTPSROOT_ID     = aws_efs_access_point.ga_ap["ghttpsroot${each.key}"].id
  MOD_DB_ADDRESS              = aws_db_instance.ga_mysql.address
  MOD_BRANCH_NAME             = var.BRANCH_NAME
  MOD_ECS_ROLE_ARN            = aws_iam_role.ga_ecs_role.arn
  MOD_ECS_TASK_ROLE_ARN       = aws_iam_role.ga_ecs_task_role.arn
  MOD_ECR_IMAGE               = var.ECR_IMAGE
  MOD_DB_USERNAME             = var.DB_USERNAME
  MOD_DB_PASSWORD             = var.DB_PASSWORD
  MOD_ADMIN_DB_USERNAME       = var.ADMIN_DB_USERNAME
  MOD_ADMIN_DB_PASSWORD       = var.ADMIN_DB_PASSWORD
  MOD_FORCE_REFRESH           = var.FORCE_REFRESH
  MOD_FRESH_INSTALL           = var.FRESH_INSTALL
  MOD_CLUSTER_ID              = aws_ecs_cluster.ga_cluster.id
  MOD_SUBNETS                 = data.aws_subnets.app.ids
  MOD_SECURITY_GROUP_ID       = data.aws_security_group.app.id
  MOD_TARGET_GROUP_ARN        = aws_lb_target_group.ga_tg.arn
  MOD_TARGET_GROUP_8443_ARN   = aws_lb_target_group.ga_tg_8443.arn
  MOD_TARGET_GROUP_22_ARN   = aws_lb_target_group.ga_tg_22.arn
  MOD_TASK_DEFINITION_CPU     = var.TASK_DEFINITION_CPU
  MOD_TASK_DEFINITION_MEMORY  = var.TASK_DEFINITION_MEMORY
}