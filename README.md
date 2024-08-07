# Introduction
This project is a proof of concept for GoAnywhere.

# Getting Started
## Server Prerequisites

## Application Prerequisites

## File Structure

# Build Instructions

## Application Build
Run the following commands from the project root directory:
```
blah blah blah
```

## Container Image Build
Run the following commands from the project root directory:
```
blah blah blah
```

# Runtime

## Environment Variables
The following environment variables are used to control the application at run-time. You can refer to the config/example.tfvars file for a working local example. Refer to [Create link to app documentation](https://www.google.com) for variables extended description and possible values. Mandatory variables are marked with an asterisk.

> **ACCOUNT**: The AWS account number.

> **ADMIN_DB_USERNAME**: The DB username for the admin account.

> **ADMIN_DB_PASSWORD**: The DB password for the admin account.

> BRANCH_NAME: The branch name used for resources creation. This value is auto-generated.

> **DB_INSTANCE_CLASS**: The database intance class for the application.

> **DB_USERNAME**: The DB username for the application.

> **DB_PASSWORD**: The DB password for the application.

> ECR_IMAGE: The ECR image name used for the task definition. This value is auto-generated.

> **ENV**: The environment in which to deploy the solution.
- Allowed values: dev, test or prod

> **FORCE_REFRESH**: If set to true, this will start the application with an empty database.

> **MFT_CLUSTER**: If set to true, this will start the application in cluster mode.
- Default value: TRUE

> **TASK_DEFINITION_CPU**: The task definition CPU.

> **TASK_DEFINITION_MEMORY**: The task definition memory.

## Run the Application Locally
```
cd [project root]/
cp ./config/example.tfvars ./dev.tfvars
```
Edit the dev.tfvars as required.
```
blah blah blah
```

# Code Check
[Checkov](https://www.checkov.io/)
[shellcheck](https://github.com/koalaman/shellcheck#how-to-use)