variable "MOD_MFT_NUMBER" {
  type = string
  description = "The number of the MFT."
}

variable "MOD_FILE_SYSTEM_ID" {
  type = string
  description = "The EFS File System Id."
}

variable "MOD_GA_AP_USERDATA_ID" {
  type = string
  description = "The USERDATA Access Point Id."
}

variable "MOD_GA_AP_SHAREDCONFIG_ID" {
  type = string
  description = "The SHAREDCONFIG Access Point Id."
}

variable "MOD_GA_AP_UPGRADER_ID" {
  type = string
  description = "The UPGRADER Access Point Id."
}

variable "MOD_GA_AP_CONFIG_ID" {
  type = string
  description = "The CONFIG Access Point Id."
}

variable "MOD_GA_AP_TOMCATSERVER_ID" {
  type = string
  description = "The TOMCATSERVER Access Point Id."
}

variable "MOD_GA_AP_TOMCATLOG_ID" {
  type = string
  description = "The TOMCATLOG Access Point Id."
}

variable "MOD_GA_AP_GHTTPSROOT_ID" {
  type = string
  description = "The GHTTPSROOT Access Point Id."
}

variable "MOD_DB_ADDRESS" {
  type = string
  description = "The DB address for the application."
}

variable "MOD_ECR_IMAGE" {
  type = string
  description = "The image name used for task definition."
}

variable "MOD_DB_USERNAME" {
  type = string
  description = "The DB username for the application."
}

variable "MOD_DB_PASSWORD" {
  type = string
  description = "The DB password for the application."
}

variable "MOD_ADMIN_DB_USERNAME" {
  type = string
  description = "The DB username for the admin account."
}

variable "MOD_ADMIN_DB_PASSWORD" {
  type = string
  description = "The DB password for the admin account."
}

variable "MOD_FORCE_REFRESH" {
  type = string
  description = "If set to true, this will start the application with an empty database."
}

variable "MOD_BRANCH_NAME" {
  type = string
  description = "The branch name used for resources creation."
}

variable "MOD_ACCOUNT" {
  type = string
  description = "The account number."
}

variable "MOD_CLUSTER_ID" {
  type = string
  description = "The Cluster Id."
}

variable "MOD_SUBNETS" {
  type = list
  description = "The list of Subnets."
}

variable "MOD_SECURITY_GROUP_ID" {
  type = string
  description = "The Security Group Id."
}

variable "MOD_TARGET_GROUP_ARN" {
  type = string
  description = "The Target Group ARN."
}