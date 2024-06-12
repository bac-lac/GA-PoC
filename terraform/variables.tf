variable "ENV" {
  type = string
  description = "The environment in which to deploy the solution."
}

variable "ACCOUNT" {
  type = string  
  sensitive = true
  description = "The account number."
}

variable "VPC_ID" {
  type = string
  sensitive = true
  description = "VPC ID in which to create the security groups."
}

variable "ADMIN_DB_USERNAME" {
  type = string
  sensitive = true
  description = "The DB username for the admin account."
}

variable "ADMIN_DB_PASSWORD" {
  type = string
  sensitive = true
  description = "The DB password for the admin account."
}

variable "BRANCH_NAME" {
  type = string
  sensitive = true
  description = "The branch name used for resources creation."
}

variable "ECR_IMAGE" {
  type = string
  sensitive = true
  description = "The image name used for task definition."
}

variable "DB_USERNAME" {
  type = string
  sensitive = true
  description = "The DB username for the application."
}

variable "DB_PASSWORD" {
  type = string
  sensitive = true
  description = "The DB password for the application."
}

variable "IS_PR" {
  type = string 
  sensitive = false
  default = "false"
  description = "True if it's a pull request"
}