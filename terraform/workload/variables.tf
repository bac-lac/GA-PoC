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

variable "ALB_NAME" {
  type = string
  description = "The name of the application load balancer."
  default = "ga-alb"
}

variable "BRANCH_ENV" {
  type = string
  description = "The granch or environmenet based on the branch value."
  default = "dev"
}

variable "BRANCH_NAME" {
  type = string
  description = "The branch name used for resources creation."
  default = "main"
}

variable "CERT_BODY" {
  type = string
  sensitive = true  
  description = "The certificate body."
  default = "CERT_BODY"
}

variable "CERT_CHAIN" {
  type = string
  sensitive = true  
  description = "The certificate chain."
  default = "CERT_CHAIN"
}

variable "CERT_PRIVATE_KEY" {
  type = string
  sensitive = true
  description = "The certificate private key."
  default = "CERT_PRIVATE_KEY"
}

variable "CLOUDWATCH_EMAIL" {
  type = string
  description = "The email used for cloudwatch endpoint."
  default = "cloudwatch_email@domain.com"
}

variable "DB_INSTANCE_CLASS" {
  type = string
  description = "The database intance class for the application."
  default = "db.t3.medium"
}

variable "DB_INSTANCE_CLASS_MEMORY" {
  type = string
  description = "The database intance class available memory in GB."
  default = "4"
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
  description = "The image name used for task definition."
  default = "ECR_IMAGE"
}

variable "ENV" {
  type = string
  description = "The environment in which to deploy the solution."
  default = "dev"
}

variable "EXTERNAL_ID" {
  type = string  
  sensitive = true
  description = "External ID of the automation account role."
  default = "EXTERNAL_ID"
}

variable "FORCE_REFRESH" {
  type = string
  description = "If set to true, this will start the application with an empty database."
  default = "FALSE"
}

variable "FRESH_INSTALL" {
  type = string
  description = "If set to TRUE, it will do a fresh install of the filesystem."
  default = "FALSE"
}

variable "MFT_CLUSTER" {
  type = string
  description = "If set to true, this will start the application in cluster mode."
  default = "TRUE"
}

variable "NLB_NAME" {
  type = string
  description = "The name of the network load balancer."
  default = "ga-nlb"
}

variable "ROLE_ARN" {
  type = string  
  sensitive = true
  description = "ARN of the role used by terraform."
  default = "ARN"
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