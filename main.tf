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

 resource "aws_s3_bucket" "storage-1" {
   bucket = "ga-storage-${var.ENV}"
 }