provider "aws" { region = "us-east-1" }
variable "asg_name" {}
variable "notification_email" {}
resource "aws_sns_topic" "alerts" { name = "flentas-alerts" }
resource "aws_sns_topic_subscription" "email_sub" { topic_arn = aws_sns_topic.alerts.arn; protocol = "email"; endpoint = var.notification_email }
resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name = "flentas-high-cpu"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  statistic = "Average"
  period = 300
  evaluation_periods = 2
  threshold = 70
  comparison_operator = "GreaterThanThreshold"
  alarm_actions = [aws_sns_topic.alerts.arn]
  dimensions = { AutoScalingGroupName = var.asg_name }
}
