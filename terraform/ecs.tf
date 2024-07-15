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
  ga_ap_userdata_id  = ga_ap_userdata_id
  ga_ap_sharedconfig_id  = ga_ap_sharedconfig_id
  ga_ap_upgrader1_id  = ga_ap_upgrader1_id
  ga_ap_config1_id  = ga_ap_config1_id
  ga_ap_tomcatserver1_id  = ga_ap_tomcatserver1_id
  ga_ap_tomcatlog1_id  = ga_ap_tomcatlog1_id
  ga_ap_ghttpsroot1_id  = ga_ap_ghttpsroot1_id
  db_address  = aws_db_instance.ga_mysql.address
}