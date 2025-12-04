provider "aws" { region = "us-east-1" }
variable "bucket_name" {}
resource "aws_iam_role" "ec2_s3_role" {
  name = "flentas-ec2-s3-role"
  assume_role_policy = jsonencode({
    Version="2012-10-17",
    Statement=[{ Effect="Allow", Principal={ Service="ec2.amazonaws.com" }, Action="sts:AssumeRole" }]
  })
}
resource "aws_iam_policy" "s3_policy" {
  name = "flentas-ec2-s3-policy"
  policy = jsonencode({
    Version="2012-10-17",
    Statement=[{ Effect="Allow", Action=["s3:GetObject","s3:PutObject","s3:ListBucket"], Resource=["arn:aws:s3:::${var.bucket_name}","arn:aws:s3:::${var.bucket_name}/*"] }]
  })
}
resource "aws_iam_role_policy_attachment" "attach" {
  role = aws_iam_role.ec2_s3_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}
resource "aws_iam_instance_profile" "profile" {
  name = "flentas-ec2-profile"
  role = aws_iam_role.ec2_s3_role.name
}
output "instance_profile" { value = aws_iam_instance_profile.profile.name }
