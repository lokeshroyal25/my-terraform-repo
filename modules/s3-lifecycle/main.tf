resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = var.sse_algorithm
        kms_master_key_id = var.sse_algorithm == "aws:kms" ? var.kms_key_id : null
      }
    }
  }

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