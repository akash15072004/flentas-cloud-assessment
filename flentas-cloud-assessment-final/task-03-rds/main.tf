provider "aws" { region = "us-east-1" }
variable "private_subnets" { type = list(string) }
variable "db_username" {}
variable "db_password" { sensitive = true }
variable "rds_sg" {}

resource "aws_db_subnet_group" "rds_sn" {
  name = "flentas-rds-sn"
  subnet_ids = var.private_subnets
}

resource "aws_db_instance" "mysql" {
  identifier = "flentas-mysql"
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  username = var.db_username
  password = var.db_password
  db_subnet_group_name = aws_db_subnet_group.rds_sn.name
  vpc_security_group_ids = [var.rds_sg]
  skip_final_snapshot = true
  publicly_accessible = false
}
output "rds_endpoint" { value = aws_db_instance.mysql.address }
