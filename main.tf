terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.45.0"
    }
  }

  backend "s3" {
    bucket      = "ga-poc-tfstate"
    region      = "ca-central-1"
    encrypt     = true
  }
}

provider "aws" {
  region  = "ca-central-1"
  assume_role {
    role_arn    = "arn:aws:iam::${var.ACCOUNT}:role/terraform-role"
  }
}

resource "aws_security_group" "ga_db_sg" {
  name        = "GA-DB-${var.BRANCH_NAME}-sg"
  description = "Allow traffic between ECS and DB"
  vpc_id      = var.VPC_ID
  tags = {
    Name = "GA-DB-${var.BRANCH_NAME}-sg"
  }
}

resource "aws_security_group" "ga_app_sg" {
  name        = "GA-App-${var.BRANCH_NAME}-sg"
  description = "Allow traffic between Load Balancer and ECS"
  vpc_id      = var.VPC_ID
  tags = {
    Name = "GA-App-${var.BRANCH_NAME}-sg"
  }
}

resource "aws_security_group" "ga_lb_sg" {
  name        = "GA-LB-${var.BRANCH_NAME}-sg"
  description = "Allow traffic to Load Balancer"
  vpc_id      = var.VPC_ID
  tags = {
    Name = "GA-LB-${var.BRANCH_NAME}-sg"
  }
}

resource "aws_security_group_rule" "allow_tcp_3306" {
  security_group_id         = aws_security_group.ga_db_sg.id
  source_security_group_id  = aws_security_group.ga_app_sg.id
  from_port                 = 3306
  protocol                  = "tcp"
  to_port                   = 3306
  type                      = "ingress"
}

resource "aws_security_group_rule" "allow_tcp_443" {
  security_group_id         = aws_security_group.ga_app_sg.id
  source_security_group_id  = aws_security_group.ga_lb_sg.id
  from_port                 = 443
  protocol                  = "tcp"
  to_port                   = 443
  type                      = "ingress"
}

resource "aws_security_group_rule" "allow_internet" {
  security_group_id         = aws_security_group.ga_lb_sg.id
  cidr_blocks               = ["0.0.0.0/0"]
  from_port                 = 443
  protocol                  = "tcp"
  to_port                   = 443
  type                      = "ingress"
}

data "aws_subnets" "selected" {
  filter {
    name   = "tag:Name"
    values = ["*Data*"]
  }
}

resource "aws_db_subnet_group" "data" {
  name       = "ga-db-subnet-group"
  subnet_ids = data.aws_subnets.selected.ids
}

resource "aws_db_instance" "ga_mysql" {
  allocated_storage         = 20
  db_name                   = format("GA%s", replace("${var.BRANCH_NAME}", "-", ""))
  engine                    = "mysql"
  engine_version            = "8.0.35"
  instance_class            = "db.t3.micro"
  username                  = var.ADMIN_DB_USERNAME
  password                  = var.ADMIN_DB_PASSWORD
  parameter_group_name      = "default.mysql8.0"
  skip_final_snapshot       = true
  storage_encrypted         = true
  vpc_security_group_ids    = [aws_security_group.ga_db_sg.id]
  db_subnet_group_name      = aws_db_subnet_group.data.name
}