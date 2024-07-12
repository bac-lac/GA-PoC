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
            },
            {
                "name": "FORCE_REFRESH",
                "value": "${var.FORCE_REFRESH}"
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

