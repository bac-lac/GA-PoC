data "aws_iam_policy_document" "ga_rds_monitoring_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ga_rds_monitoring_role" {
  name                = "ga_rds_monitoring_role-${var.BRANCH_NAME}"
  description         = "Provides access to Cloudwatch for RDS Enhanced Monitoring"
  assume_role_policy  = data.aws_iam_policy_document.ga_rds_monitoring_assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"]
}

data "aws_iam_policy_document" "ga_ecs_role_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "ga_ecs_role_inline_policy" {
  statement {
    effect    = "Allow"
    actions   = ["logs:CreateLogGroup"]
    resources = ["arn:aws:logs:ca-central-1:${var.ACCOUNT}:log-group:*:*"]
  }
}

data "aws_iam_policy_document" "ga_ecs_task_role_inline_policy" {
  statement {
    effect    = "Allow"
    actions   = ["ecs:ExecuteCommand","ecs:DescribeTasks"]
    resources = ["arn:aws:ecs:ca-central-1:${var.ACCOUNT}:task/cluster-name/*","arn:aws:ecs:ca-central-1:${var.ACCOUNT}:cluster/*"]
  }
}

resource "aws_iam_role" "ga_ecs_role" {
  name                = "ga_ecs_role-${var.BRANCH_NAME}"
  description         = "Provides access to other AWS service resources that are required to run Amazon ECS tasks"
  assume_role_policy  = data.aws_iam_policy_document.ga_ecs_role_assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
  inline_policy {
    name   = "ga_ecs_role_inline_policy"
    policy = data.aws_iam_policy_document.ga_ecs_role_inline_policy.json
  }
}

resource "aws_iam_role" "ga_ecs_task_role" {
  name                = "ga_ecs_task_role-${var.BRANCH_NAME}"
  description         = "Provides access to other AWS service resources that are required to run Amazon ECS tasks"
  assume_role_policy  = data.aws_iam_policy_document.ga_ecs_role_assume_role.json
  inline_policy {
    name   = "ga_ecs_task_role_inline_policy"
    policy = data.aws_iam_policy_document.ga_ecs_task_role_inline_policy.json
  }
}