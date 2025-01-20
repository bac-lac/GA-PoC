variable "ACCOUNT" {
  type = string  
  sensitive = true
  description = "The account number."
  default = "ACCOUNT"
}

variable "ADMIN_DB_PASSWORD" {
  type = string
  sensitive = true
  description = "The DB password for the admin account."
  default = "ADMIN_DB_PASSWORD"
}

variable "ADMIN_DB_USERNAME" {
  type = string
  sensitive = true
  description = "The DB username for the admin account."
  default = "ADMIN_DB_USERNAME"
}

variable "BRANCH_NAME" {
  type = string
  sensitive = false
  description = "The branch name used for resources creation."
  default = "main"
}

variable "DB_INSTANCE_CLASS" {
  type = string
  sensitive = true
  description = "The database intance class for the application."
  default = "db.t3.medium"
}

variable "DB_PASSWORD" {
  type = string
  sensitive = true
  description = "The DB password for the application."
  default = "DB_PASSWORD"
}

variable "DB_USERNAME" {
  type = string
  sensitive = true
  description = "The DB username for the application."
  default = "DB_USERNAME"
}

variable "ECR_IMAGE" {
  type = string
  sensitive = false
  description = "The image name used for task definition."
  default = "ECR_IMAGE"
}

variable "ENV" {
  type = string
  description = "The environment in which to deploy the solution."
  default = "dev"
}

variable "FORCE_REFRESH" {
  type = string
  description = "If set to true, this will start the application with an empty database."
  default = "FALSE"
}

variable "FRESH_INSTALL" {
  type = string
  description = "If set to true, it will do a fresh install of the filesystem."
  default = "FALSE"
}

variable "MFT_CLUSTER" {
  type = string
  description = "If set to true, this will start the application in cluster mode."
  default = "TRUE"
}

variable "TASK_DEFINITION_CPU" {
  type = number
  description = "The task definition CPU."
  default = 1024
}

variable "TASK_DEFINITION_MEMORY" {
  type = number
  description = "The task definition memory."
  default = 3072
}