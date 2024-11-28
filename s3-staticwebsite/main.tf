provider "aws" {
  region     = var.aws_region
  access_key = var.iam_user_access_key
  secret_key = var.iam_user_secret_key
}

resource "aws_s3_bucket" "static_website" {
  bucket        = var.s3_bucket_name
  force_destroy = true

  tags = {
    Name        = "Static Website Bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_website_configuration" "static_website" {
  bucket = aws_s3_bucket.static_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.static_website.id
  key    = "index.html"
  content = <<EOT
<!DOCTYPE html>
<html>
<head>
    <title>Welcome to My Website</title>
</head>
<body>
    <h1>Hello, World!</h1>
    <p>This is a static website hosted on S3.</p>
</body>
</html>
EOT
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket = aws_s3_bucket.static_website.id
  key    = "error.html"
  content = <<EOT
<!DOCTYPE html>
<html>
<head>
    <title>Error Page</title>
</head>
<body>
    <h1>Oops!</h1>
    <p>The page you are looking for does not exist.</p>
</body>
</html>
EOT
  content_type = "text/html"
}

resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.static_website.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.static_website.arn}/*"
      }
    ]
  })
}

resource "aws_iam_policy" "s3_policy" {
  name        = "S3PublicAccessPolicy"
  description = "Policy to manage public access for S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:PutBucketPolicy",
          "s3:PutBucketPublicAccessBlock",
          "s3:GetBucketPolicy",
          "s3:PutObject",
          "s3:GetObject"
        ],
        Resource = [
          "arn:aws:s3:::my-static-website-bucket-*",
          "arn:aws:s3:::my-static-website-bucket-*/*"
        ]
      }
    ]
  })
}

resource "aws_iam_user" "s3_user" {
  name = var.iam_user_name
}

resource "aws_iam_user_policy_attachment" "s3_user_policy" {
  user       = aws_iam_user.s3_user.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

output "s3_static_website_url" {
  value       = aws_s3_bucket_website_configuration.static_website.website_endpoint
  description = "The URL for the S3 static website"
}

