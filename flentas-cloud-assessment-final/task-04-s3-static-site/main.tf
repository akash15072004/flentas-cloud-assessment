provider "aws" { region = "us-east-1" }
resource "random_id" "suffix" { byte_length = 4 }
resource "aws_s3_bucket" "site" {
  bucket = "flentas-static-site-${random_id.suffix.hex}"
  acl    = "public-read"
  website { index_document = "index.html" }
  force_destroy = true
}
resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.site.id
  key = "index.html"
  content = file("${path.module}/index.html")
  content_type = "text/html"
  acl = "public-read"
}
output "website_url" { value = aws_s3_bucket.site.website_endpoint }
