variable "aws_region" {
  description = "The AWS region to deploy resources"
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  default     = "my-bucket-name"
}

variable "static_website_bucket_name" {
  description = "The name of the bucket for static website hosting"
  default     = "my-static-website"
}

variable "db_engine" {
  default = "mysql"
}

variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "db_allocated_storage" {
  default = 20
}

variable "db_name" {
  default = "mydb"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  default = "password"
}

variable "security_group_ids" {
  type = list(string)
  default = ["sg-12345678"]
}