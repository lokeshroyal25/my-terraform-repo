variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "sse_algorithm" {
  description = "The server-side encryption algorithm (SSE-S3 or aws:kms)"
  type        = string
  default     = "AES256"
}

variable "kms_key_id" {
  description = "The KMS key ID for SSE-KMS encryption"
  type        = string
  default     = null
}