variable "ENV" {
  type = string
  description = "The environment in which to deploy the solution."
}

variable "ACCOUNT" {
  type = string  
  description = "The account number."
}

variable "VPC_ID" {
  type = string
  description = "VPC ID in which to create the security groups"
}