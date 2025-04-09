# Introduction
This project is a proof of concept for GoAnywhere.

# Build Instructions

## Container Image Build
Run the following commands from the project root directory:
```
docker build -t ga:latest --file docker/Dockerfile .
```

## Environment Variables
The following environment variables are used to control the application at run-time. Mandatory variables are marked with an asterisk.

> ACCOUNT *: The AWS account number.
- Default value: ACCOUNT

> ADMIN_DB_USERNAME *: The DB username for the admin account.
- Default value: ADMIN_DB_USERNAME

> ADMIN_DB_PASSWORD *: The DB password for the admin account.
- Default value: ADMIN_DB_PASSWORD

> ALB_NAME *: The name of the application load balancer.
- Default value: ga-alb

> BRANCH_NAME: The branch name used for resources creation. This value is auto-generated.
- Default value: main

> CERT_BODY *: The certificate body.
- Default value: CERT_BODY

> CERT_PRIVATE_KEY *: The certificate private key.
- Default value: CERT_PRIVATE_KEY

> DB_INSTANCE_CLASS *: The database intance class for the application.
- Default value: db.t3.medium

> DB_USERNAME *: The DB username for the application.
- Default value: DB_USERNAME

> DB_PASSWORD *: The DB password for the application.
- Default value: DB_PASSWORD

> ECR_IMAGE: The ECR image name used for the task definition. This value is auto-generated.
- Default value: ECR_IMAGE

> ENV *: The environment in which to deploy the solution.
- Default value: dev
- Allowed values: dev, test or prod

> EXTERNAL_ID *: External ID of the automation account role.
- Default value: EXTERNAL_ID

> FORCE_REFRESH *: If set to true, this will start the application with an empty database.
- Default value: FALSE
- Note: When refreshing the DB, the license needs to be removed in the UI before setting the variable to TRUE and running the pipeline.

> FRESH_INSTALL *: If set to TRUE, it will do a fresh install of the filesystem.
- Default value: FALSE

> MFT_CLUSTER *: If set to true, this will start the application in cluster mode.
- Default value: TRUE

> NLB_NAME *: The name of the network load balancer.
- Default value: ga-nlb

> ROLE_ARN *: ARN of the role used by terraform..
- Default value: ROLE_ARN

> TASK_DEFINITION_CPU *: The task definition CPU.
- Default value: 1024

> TASK_DEFINITION_MEMORY *: The task definition memory.
- Default value: 3072

## Run the Application Locally

1. Build the application container as per the above [Container Image Build](#container-image-build) instructions.
1. Edit the local.env as required.
1. Run the following command from the project **docker** directory:
    ```
    docker compose up -d
    ```

# Code Check
[Checkov](https://www.checkov.io/)
[shellcheck](https://github.com/koalaman/shellcheck#how-to-use)