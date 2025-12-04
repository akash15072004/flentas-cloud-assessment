Remote backend example (S3 + DynamoDB):

terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "flentas/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "flentas-locks"
  }
}

Destroy steps:
- terraform destroy in each module
- manually delete S3 buckets (force destroy) and EIPs/NAT Gateways
