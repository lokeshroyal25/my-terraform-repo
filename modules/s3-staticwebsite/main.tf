resource "aws_s3_bucket" "static_website" {
  bucket        = var.s3_bucket_name
  force_destroy = true
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