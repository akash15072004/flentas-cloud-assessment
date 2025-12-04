Flentas Cloud Engineer Internship - Final Report
===============================================

Author: Akash Chaudhary

Summary
-------
This repository implements the Cloud Engineer technical assessment using Terraform on AWS. It contains 8 tasks: VPC, EC2+ASG+ALB, RDS, S3 static site, IAM role, Lambda+API Gateway, CloudWatch+SNS, and Terraform backend/destroy guide.

Each task has a production-ready `main.tf`, `variables.tf` and sample `terraform.tfvars`. Deploy using `deploy.sh` (careful: may incur AWS charges).

Files included
--------------
- common-variables.tf : shared variables
- task-01-vpc/... : VPC module
- task-02-ec2-asg-elb/... : Web tier with ALB and ASG
- task-03-rds/... : RDS MySQL in private subnets
- task-04-s3-static-site/... : S3 static website
- task-05-iam-ec2-s3/... : IAM role and policy for EC2 to access S3
- task-06-lambda-apigw/... : Lambda + API Gateway HTTP API
- task-07-cloudwatch-sns/... : CloudWatch alarm + SNS
- task-08-backend-destroy/... : Backend and destroy instructions
- architecture.puml : PlantUML diagram
- deploy.sh : automated deploy script

Cost & Safety
-----------
- Use Free Tier eligible instance types (t3.micro/t2.micro).
- NAT Gateway and RDS may incur charges; destroy resources after testing.
- Always run `terraform plan` before `apply`.

Screenshot Guide
----------------
For each task capture:
- Console view showing resource IDs and statuses
- Terraform apply outputs
- Working endpoint for ALB/S3/API Gateway
- Confirmed SNS subscription email (CloudWatch alerts)

