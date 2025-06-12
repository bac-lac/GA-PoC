terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.45.0"
    }
  }

  backend "s3" {
    bucket      = "main-tfstate-c71307a3"
    region      = "ca-central-1"
    encrypt     = true
  }
}

provider "aws" {
  region  = "ca-central-1"
  assume_role {
    role_arn    = "${var.ROLE_ARN}"
    external_id = "${var.EXTERNAL_ID}"
  }
}

data "aws_security_group" "web" {
  filter {
    name   = "tag:Name"
    values = ["*Web*"]
  }
}

data "aws_subnets" "web" {
  filter {
    name   = "tag:Name"
    values = ["*Web*"]
  }
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["*"]
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "SSH_sg-${var.ENV}"
  description = "Allow ssh for sftp."
  vpc_id      = data.aws_vpc.vpc.id

  tags = {
    Name = "SSH_sg"
  }
}

resource "aws_security_group_rule" "ssh" {
  description       = "Allow ssh for sftp."
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.allow_ssh.id
}

resource "aws_lb" "ga_alb" {
  name                              = "ga-alb-${var.ENV}"
  internal                          = true
  load_balancer_type                = "application"
  security_groups                   = [data.aws_security_group.web.id]
  subnets                           = data.aws_subnets.web.ids
  enable_cross_zone_load_balancing  = true
  enable_deletion_protection        = true

  tags = {
    Environment = "${var.ENV}"
  }
}

resource "aws_lb" "ga_nlb" {
  name                              = "ga-nlb-${var.ENV}"
  internal                          = true
  load_balancer_type                = "network"
  security_groups                   = [data.aws_security_group.web.id, aws_security_group.allow_ssh.id]
  subnets                           = data.aws_subnets.web.ids
  enable_cross_zone_load_balancing  = true
  enable_deletion_protection        = true

  tags = {
    Environment = "${var.ENV}"
  }
}

variable "ENV" {
  type = string
  description = "The environment in which to deploy the solution.11111"
  default = "dev"
}

variable "EXTERNAL_ID" {
  type = string  
  sensitive = true
  description = "External ID of the automation account role."
  default = "EXTERNAL_ID"
}

variable "ROLE_ARN" {
  type = string  
  sensitive = true
  description = "ARN of the role used by terraform."
  default = "ARN"
}