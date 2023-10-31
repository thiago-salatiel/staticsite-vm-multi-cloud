resource "aws_s3_bucket" "bucket" {
  provider = aws.cloud
  bucket   = "lalala"
}

resource "aws_s3_bucket_ownership_controls" "bucket-ownership" {
  provider = aws.cloud
  bucket   = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket-public-access" {
  provider                = aws.cloud
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "bucket-acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket-ownership,
    aws_s3_bucket_public_access_block.bucket-public-access,
  ]
  provider = aws.cloud
  bucket   = aws_s3_bucket.bucket.id
  acl      = "public-read"
}

resource "aws_s3_bucket_website_configuration" "bucket-website-configuration" {
  provider = aws.cloud
  bucket   = aws_s3_bucket.bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

variable "website_endpoint" {
  default = "true"
}

output "aws_s3_bucket_website_endpoint" {
  value = "http://${var.website_endpoint == "true" ? aws_s3_bucket_website_configuration.bucket-website-configuration.website_endpoint : ""}"
}

resource "aws_s3_object" "bucket-objects" {
  depends_on = [
    aws_s3_bucket_acl.bucket-acl,
  ]
  provider     = aws.cloud
  bucket       = aws_s3_bucket.bucket.id
  for_each     = fileset("../../app/", "*")
  key          = each.value
  source       = "../../app/${each.value}"
  acl          = "public-read"
  content_type = "text/html"
  etag         = md5(file("../../app/${each.value}"))
}

resource "aws_s3_bucket_versioning" "bucket-versioning" {
  provider = aws.cloud
  bucket   = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}