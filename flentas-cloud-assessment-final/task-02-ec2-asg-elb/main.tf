terraform {
  required_providers { aws = { source = "hashicorp/aws" } }
}
provider "aws" { region = "us-east-1" }

variable "vpc_id" {}
variable "public_subnets" { type = list(string) }
variable "my_ip_cidr" {}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners = ["amazon"]
  filter { name = "name"; values = ["amzn2-ami-hvm-*-x86_64-gp2"] }
}

resource "aws_security_group" "alb_sg" {
  name = "alb-sg"
  vpc_id = var.vpc_id
  ingress { from_port=80; to_port=80; protocol="tcp"; cidr_blocks=["0.0.0.0/0"] }
  egress { from_port=0; to_port=0; protocol="-1"; cidr_blocks=["0.0.0.0/0"] }
}

resource "aws_security_group" "instance_sg" {
  name = "instance-sg"
  vpc_id = var.vpc_id
  ingress { from_port=22; to_port=22; protocol="tcp"; cidr_blocks=[var.my_ip_cidr] }
  ingress { from_port=80; to_port=80; protocol="tcp"; security_groups=[aws_security_group.alb_sg.id] }
  egress { from_port=0; to_port=0; protocol="-1"; cidr_blocks=["0.0.0.0/0"] }
}

resource "aws_launch_template" "web" {
  name_prefix = "flentas-web-"
  image_id = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  user_data = filebase64("${path.module}/user_data.sh")
  network_interfaces { associate_public_ip_address = true; security_groups = [aws_security_group.instance_sg.id] }
}

resource "aws_lb" "alb" {
  name = "flentas-alb"
  load_balancer_type = "application"
  security_groups = [aws_security_group.alb_sg.id]
  subnets = var.public_subnets
}

resource "aws_lb_target_group" "tg" {
  name = "flentas-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  health_check { path = "/"; interval = 30 }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80
  default_action { type = "forward"; target_group_arn = aws_lb_target_group.tg.arn }
}

resource "aws_autoscaling_group" "asg" {
  name = "flentas-asg"
  desired_capacity = 1
  max_size = 2
  min_size = 1
  vpc_zone_identifier = var.public_subnets
  launch_template { id = aws_launch_template.web.id; version = "$Latest" }
  target_group_arns = [aws_lb_target_group.tg.arn]
  tag { key="Name"; value="flentas-web"; propagate_at_launch=true }
}
