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
  mft_number      = "1"
  file_system_id  = file_system_id
  ga_ap_userdata_id  = aws_efs_access_point.ga_ap_userdata.id
  ga_ap_sharedconfig_id  = aws_efs_access_point.ga_ap_sharedconfig.id
  ga_ap_upgrader1_id  = aws_efs_access_point.ga_ap_upgrader1.id
  ga_ap_config1_id  = aws_efs_access_point.ga_ap_config1.id
  ga_ap_tomcatserver1_id  = aws_efs_access_point.ga_ap_tomcatserver1.id
  ga_ap_tomcatlog1_id  = aws_efs_access_point.ga_ap_tomcatlog1.id
  ga_ap_ghttpsroot1_id  = aws_efs_access_point.ga_ap_ghttpsroot1.id
  db_address  = aws_db_instance.ga_mysql.address
}