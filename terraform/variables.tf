variable "ACCOUNT" {
  type = string  
  sensitive = true
  description = "The account number."
}

variable "ADMIN_DB_PASSWORD" {
  type = string
  sensitive = true
  description = "The DB password for the admin account."
}

variable "ADMIN_DB_USERNAME" {
  type = string
  sensitive = true
  description = "The DB username for the admin account."
}

variable "BRANCH_NAME" {
  type = string
  sensitive = false
  description = "The branch name used for resources creation."
}

variable "DB_PASSWORD" {
  type = string
  sensitive = true
  description = "The DB password for the application."
}

variable "DB_USERNAME" {
  type = string
  sensitive = true
  description = "The DB username for the application."
}

variable "ECR_IMAGE" {
  type = string
  sensitive = false
  description = "The image name used for task definition."
}

variable "ENV" {
  type = string
  description = "The environment in which to deploy the solution."
}

variable "FORCE_REFRESH" {
  type = string
  description = "If set to true, this will start the application with an empty database."
}

variable "VPC_ID" {
  type = string
  sensitive = true
  description = "VPC ID in which to create the security groups."
}