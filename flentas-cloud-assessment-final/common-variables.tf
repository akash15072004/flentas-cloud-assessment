variable "vpc_id" { description = "VPC ID" type = string }
variable "public_subnets" { description = "Public subnet IDs" type = list(string) }
variable "private_subnets" { description = "Private subnet IDs" type = list(string) }
variable "my_ip_cidr" { description = "Your public IP address for SSH" type = string }
variable "db_username" { description = "RDS username" type = string }
variable "db_password" { description = "RDS password" type = string sensitive = true }
variable "notification_email" { description = "Email for SNS alerts" type = string }
variable "asg_name" { description = "ASG name for CloudWatch alarms" type = string }
variable "rds_sg" { description = "RDS security group ID" type = string }
