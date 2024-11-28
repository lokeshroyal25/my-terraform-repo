variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "iam_user_name" {
  description = "IAM user name"
  type        = string
}

variable "iam_user_access_key" {
  description = "Access key for IAM user"
  type        = string
  sensitive   = true
}

variable "iam_user_secret_key" {
  description = "Secret key for IAM user"
  type        = string
  sensitive   = true
}
