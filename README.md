## Threat Composer – ECS Deployment (Terraform + CI/CD)

This project deploys the Threat Composer application on AWS ECS Fargate, using Terraform for Infrastructure-as-Code and GitHub Actions for CI/CD automation.
It includes complete infrastructure: VPC, ALB, ECS Cluster, ECR, Route53, ACM, IAM, Security Groups, and automated CI/CD pipelines.

## Project Structure
```

├── .github/
│ └── workflows/
│ ├── apply.yml
│ ├── destroy.yml
│ ├── push-image.yml
│ └── plan.yml
│
├── My-App/
│ └── Dockerfile
│
└── Terraform/
├── main.tf
├── provider.tf
├── variables.tf
└── modules/
├── ACM/
├── ALB/
├── ECS/
├── Route53/
├── VPC/
└── IAM/
```


To run the Threat Composer app locally:

```yarn install
yarn build
yarn global add serve
serve -s build
```

## 🐳 Containerization (Docker)

The application is containerized using a production-ready Dockerfile located under My-App/.

What this solves?

“Works on my system” issues are eliminated

Ensures consistent runtime between dev, staging, and production

Enables automated deployment into ECS Fargate

The GitHub pipeline builds and pushes this image to Amazon ECR securely.

## Terraform Infrastructure

This project uses Infrastructure-as-Code to provision all required AWS resources.
State is stored in a remote backend (S3 + DynamoDB state locking) for safe collaboration.

Main Terraform Modules

## VPC Module

Creates public subnets

Internet Gateway to provide internet access to the subnets

Route tables for networking and providing route to the subnets.

## ALB Module

Application Load Balancer for routing traffic

HTTP → HTTPS redirect

Target group listening on container port 8080 which is serving nginx

Integrated health checks

## ECS Module

ECS Cluster (Fargate)

Task definition referencing ECR image

ECS Service wired to the ALB target group

Cloud watch enabled to saved ECS Logs

## Route53 Module

DNS record for my domain (www.mubashir.site)

Points cleanly to ALB

Inclues a Hosted Zone with an A record to map the ALB to my domain.

## Security Groups Module

ALB SG: Allows inbound HTTP/HTTPS

ECS SG: Allows only traffic from ALB on port 8080

Strict and secure by design to ensure maximum security.

## ACM Module

Creates & validates SSL certificate

Provides HTTPS for the domain

## IAM Module

All required execution-task and policy permissions

ECS, ECR, logging, and load balancing access

## CI/CD Pipeline (GitHub Actions)

CI/CD is fully automated using 4 workflows:

 1. push-image.yml

Builds Docker image

Runs Trivy vulnerability scanning

Pushes image to Amazon ECR

2. plan.yml

Runs:

terraform fmt

terraform validate

terraform plan

Prints infrastructure changes before deployment

3. apply.yml

Executes terraform apply -auto-approve

Deploys/updates the entire infrastructure

 4. destroy.yml

Destroys all resources cleanly when needed

## Benefits

Fully automated delivery

Consistent, repeatable deployments

Significant reduction of human error

Complete security scanning in pipeline

## Security Highlights

-App runs as non-root user in Docker

-ALB only exposes ports 80/443

-ECS tasks only accept traffic from ALB

-Infrastructure state is locked (DynamoDB)

-SSL/TLS handled via ACM

-CI/CD includes vulnerability scanning

-IAM is least-privilege

## Summary

My project creates a fully automated, secure, production-grade ECS deployment of the Threat Composer application, using modern DevOps best practices:

Dockerized application

Terraform-managed AWS infrastructure

Secure networking (SGs, HTTPS, ALB routing)

Automated CI/CD pipelines for scalable and repeatable deployments


## Potential Improvements

- Run the ECS clusters on private subnets and then use a nat gateway attached to a public subnet for added secured access to the Cluster.

- Auto Scaling group use for increase in demand or cost optimization in a production env.


## Images of Running Service

![Running Domain](app.png)

![Working CI/CD](cicd.png)

## Architecture Diagram
![Architecture Diagram](diagram.png)











