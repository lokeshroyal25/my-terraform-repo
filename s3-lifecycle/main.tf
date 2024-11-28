
provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
  acl    = "private"

  # Enable versioning
  versioning {
    enabled = true
  }

  # Enable server-side encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.sse_algorithm
        kms_master_key_id = var.sse_algorithm == "aws:kms" ? var.kms_key_id : null
      }
    }
  }

  # Add lifecycle rules
  lifecycle_rule {
    id      = "archive-old-versions"
    enabled = true

    noncurrent_version_transition {
      storage_class = "GLACIER"
      days          = 30
    }

    noncurrent_version_expiration {
      days = 365
    }
  }
}

# Output the bucket name
output "s3_bucket_name" {
  value = aws_s3_bucket.example.id
}

