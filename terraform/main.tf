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