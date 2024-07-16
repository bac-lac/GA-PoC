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
  for_each                    = var.BRANCH_NAME == "main" ? toset(["1", "2"]) : toset(["1"])
  MOD_MFT_NUMBER              = each.key
  MOD_CLUSTER                 = var.BRANCH_NAME == "main" ? "TRUE" : "FALSE"
  MOD_FILE_SYSTEM_ID          = aws_efs_file_system.ga_efs.id
  MOD_GA_AP_USERDATA_ID       = aws_efs_access_point.ga_ap_userdata.id
  MOD_GA_AP_SHAREDCONFIG_ID   = aws_efs_access_point.ga_ap_sharedconfig.id
  MOD_GA_AP_UPGRADER_ID       = each.key == "1" ? aws_efs_access_point.ga_ap_upgrader1.id : aws_efs_access_point.ga_ap_upgrader2.id
  MOD_GA_AP_CONFIG_ID         = each.key == "1" ? aws_efs_access_point.ga_ap_config1.id : aws_efs_access_point.ga_ap_config2.id
  MOD_GA_AP_TOMCATSERVER_ID   = each.key == "1" ? aws_efs_access_point.ga_ap_tomcatserver1.id : aws_efs_access_point.ga_ap_tomcatserver2.id
  MOD_GA_AP_TOMCATLOG_ID      = each.key == "1" ? aws_efs_access_point.ga_ap_tomcatlog1.id : aws_efs_access_point.ga_ap_tomcatlog2.id
  MOD_GA_AP_GHTTPSROOT_ID     = each.key == "1" ? aws_efs_access_point.ga_ap_ghttpsroot1.id : aws_efs_access_point.ga_ap_ghttpsroot2.id
  MOD_DB_ADDRESS              = aws_db_instance.ga_mysql.address
  MOD_BRANCH_NAME             = var.BRANCH_NAME
  MOD_ACCOUNT                 = var.ACCOUNT
  MOD_ECR_IMAGE               = var.ECR_IMAGE
  MOD_DB_USERNAME             = var.DB_USERNAME
  MOD_DB_PASSWORD             = var.DB_PASSWORD
  MOD_ADMIN_DB_USERNAME       = var.ADMIN_DB_USERNAME
  MOD_ADMIN_DB_PASSWORD       = var.ADMIN_DB_PASSWORD
  MOD_FORCE_REFRESH           = var.FORCE_REFRESH
  MOD_CLUSTER_ID              = aws_ecs_cluster.ga_cluster.id
  MOD_SUBNETS                 = data.aws_subnets.app.ids
  MOD_SECURITY_GROUP_ID       = data.aws_security_group.app.id
  MOD_TARGET_GROUP_ARN        = aws_lb_target_group.ga_tg.arn
}