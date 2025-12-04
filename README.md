# flentas-cloud-assessment
<p align="center">
  <img src="https://img.shields.io/badge/Terraform-v1.4+-623CE4?logo=terraform" />
  <img src="https://img.shields.io/badge/AWS-Cloud-orange?logo=amazonaws" />
  <img src="https://img.shields.io/github/last-commit/Akash-Chaudhary/flentas-cloud-assessment?color=blue" />
  <img src="https://img.shields.io/github/repo-size/Akash-Chaudhary/flentas-cloud-assessment?color=brightgreen" />
  <img src="https://img.shields.io/badge/Infrastructure--as--Code-IaC-success" />
  <img src="https://img.shields.io/badge/License-MIT-green" />
</p>

---



🚀 Flentas Cloud Engineer Internship – Technical Assessment
Infrastructure-as-Code (IaC) Implementation using Terraform & AWS
This repository contains the complete solution for the Cloud Engineer Technical Assessment assigned by Flentas Technologies.
All AWS resources are provisioned using Terraform, following industry best-practices in cloud networking, compute, storage, monitoring, IAM, and serverless architectures.

Every task is organized into its own folder with:
✔ Production-ready main.tf
✔ variables.tf
✔ Sample terraform.tfvars
✔ Support files (user_data.sh, Lambda code, website HTML, etc.)
✔ A dedicated README containing task explanation + screenshot checklist

A global shared variable file (common-variables.tf) is used to maintain consistency across modules.

📂 Repository Structure
cpp
Copy code
flentas-cloud-assessment-akash/
│
├── common-variables.tf
├── deploy.sh
├── architecture.puml
├── REPORT.md
├── REPORT.pdf
│
├── task-01-vpc/
├── task-02-ec2-asg-elb/
├── task-03-rds/
├── task-04-s3-static-site/
├── task-05-iam-ec2-s3/
├── task-06-lambda-apigw/
├── task-07-cloudwatch-sns/
└── task-08-backend-destroy/
🧩 Task Overview
1️⃣ Task 01 — VPC (Networking Foundation)
Custom VPC (10.0.0.0/16)

2 Public + 2 Private Subnets across 2 AZs

Internet Gateway + NAT Gateway

Public/private route tables

Outputs: VPC ID, subnet IDs

2️⃣ Task 02 — EC2 Auto Scaling Group + Application Load Balancer
Launch Template with Apache installed via user data

Auto Scaling Group (ASG) across 2 AZs

Application Load Balancer (ALB) routing traffic

Security Groups with least-privilege rules

Health checks + rolling updates supported

3️⃣ Task 03 — RDS MySQL (Private Subnet)
DB Subnet Group using private subnets

MySQL 8.0 (db.t3.micro - free tier eligible)

Private access only (best practice)

Encrypted storage + password stored in variables

4️⃣ Task 04 — S3 Static Website Hosting
S3 bucket for public static site

index.html uploaded via Terraform

Public access only for demonstration

Outputs website endpoint

5️⃣ Task 05 — IAM Role for EC2 to Access S3
IAM role + custom IAM policy

Scoped access to specific S3 bucket only

Instance profile for EC2 attachment

Follows least-privilege security model

6️⃣ Task 06 — Lambda Function + API Gateway
Python Lambda function

API Gateway HTTP API with Lambda Proxy Integration

IAM permission for API Gateway invocation

Serverless architecture design

7️⃣ Task 07 — CloudWatch Alarm + SNS Notification
SNS Topic + Email subscription

CloudWatch CPU Utilization Alarm on ASG

Alerts emailed when CPU threshold exceeded

8️⃣ Task 08 — Remote Backend + Destroy Guide
Backend configuration using S3 + DynamoDB

Terraform remote state + state locking

Full cleanup instructions to avoid AWS charges

Best practices for safe IaC workflows

🛠️ How to Deploy
Option 1 — Deploy Manually (Recommended)
Navigate into each task folder:

csharp
Copy code
terraform init
terraform plan
terraform apply
Destroy resources after verification:

nginx
Copy code
terraform destroy
🚀 Option 2 — Use Automated deploy.sh Script
⚠️ WARNING: This will create AWS resources and may incur charges.

Apply all modules interactively:
bash
Copy code
./deploy.sh
Apply without confirmation:
arduino
Copy code
./deploy.sh --auto
Destroy all modules:
bash
Copy code
./deploy.sh --destroy
📸 Required Screenshots for Assessment Submission
For each task provide:

Networking
VPC list

Subnets

Route tables

NAT Gateway

Compute & Load Balancing
EC2 instances

Launch template

ASG details

ALB listeners + target groups

Database
RDS instance overview

Connectivity & security tab

Endpoint

Storage
S3 bucket properties

Static website endpoint working

Serverless
Lambda console

API Gateway test run

Monitoring
SNS topic + confirmation email

CloudWatch alarm state

🧾 Documentation
REPORT.md – Summary of tasks

REPORT.pdf – PDF formatted report (can be submitted directly)

architecture.puml – UML architecture diagram (can render to PNG)

🧑‍💻 Author
Akash Chaudhary
Cloud Engineer Intern Candidate
B.Tech | Information Technology

