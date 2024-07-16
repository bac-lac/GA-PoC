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
  source              = "./modules/ecs_service/"
  MOD_MFT_NUMBER      = "1"
  MOD_FILE_SYSTEM_ID  = aws_efs_file_system.ga_efs.id
  MOD_GA_AP_USERDATA_ID  = aws_efs_access_point.ga_ap_userdata.id
  MOD_GA_AP_SHAREDCONFIG_ID  = aws_efs_access_point.ga_ap_sharedconfig.id
  MOD_GA_AP_UPGRADER1_ID  = aws_efs_access_point.ga_ap_upgrader1.id
  MOD_GA_AP_CONFIG1_ID  = aws_efs_access_point.ga_ap_config1.id
  MOD_GA_AP_TOMCATSERVER1_ID  = aws_efs_access_point.ga_ap_tomcatserver1.id
  MOD_GA_AP_TOMCATLOG1_ID  = aws_efs_access_point.ga_ap_tomcatlog1.id
  MOD_GA_AP_GHTTPSROOT1_ID  = aws_efs_access_point.ga_ap_ghttpsroot1.id
  MOD_DB_ADDRESS  = aws_db_instance.ga_mysql.address
  MOD_BRANCH_NAME = var.BRANCH_NAME
  MOD_ACCOUNT = var.ACCOUNT
  MOD_ECR_IMAGE = var.ECR_IMAGE
  MOD_DB_USERNAME = var.DB_USERNAME
  MOD_DB_PASSWORD = var.DB_PASSWORD
  MOD_ADMIN_DB_USERNAME = var.ADMIN_DB_USERNAME
  MOD_ADMIN_DB_PASSWORD = var.ADMIN_DB_PASSWORD
  MOD_FORCE_REFRESH = var.FORCE_REFRESH
  MOD_CLUSTER_ID = aws_ecs_cluster.ga_cluster.id
  MOD_SUBNETS = data.aws_subnets.app.ids
  MOD_SECURITY_GROUP_ID = data.aws_security_group.app.id
  MOD_TARGET_GROUP_ARN = aws_lb_target_group.ga_tg.arn
}