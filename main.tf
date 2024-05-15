terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.45.0"
    }
  }

  backend "s3" {
    bucket      = "ga-poc-tfstate"
    #profile = "DevOps"
    #key         = "${var.env}/terraform.tfstate"
    region      = "ca-central-1"
    encrypt     = true
    #dynamodb_table = "ga-terraform-state-${var.env}"
  }
}

  provider "aws" {
    region  = "ca-central-1"
    profile = "DevOps"
    assume_role {
      role_arn    = "arn:aws:iam::${var.ACCOUNT}:role/terraform-role"
    }
  }

  resource "aws_security_group" "ga_db_sg" {
    name        = "GA-DB-sg"
    description = "Allow traffic between ECS and DB"
    vpc_id      = var.VPC_ID
  }

  resource "aws_security_group" "ga_app_sg" {
    name        = "GA-App-sg"
    description = "Allow traffic between Load Balancer and ECS"
    vpc_id      = var.VPC_ID
  }

  resource "aws_security_group" "ga_lb_sg" {
    name        = "GA-LB-sg"
    description = "Allow traffic to Laod Balancer"
    vpc_id      = var.VPC_ID
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
    cidr_ipv4                 = "0.0.0.0/0"
    from_port                 = 443
    protocol                  = "tcp"
    to_port                   = 443
    type                      = "ingress"
  }