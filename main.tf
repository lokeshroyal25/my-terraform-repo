provider "aws" {
  region = var.aws_region
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.s3_bucket_name
}

module "static_website" {
  source         = "./modules/static_website"
  s3_bucket_name = var.static_website_bucket_name
}

module "rds" {
  source              = "./modules/rds"
  identifier          = "mydb-instance"
  db_engine           = var.db_engine
  db_instance_class   = var.db_instance_class
  db_allocated_storage = var.db_allocated_storage
  db_name             = var.db_name
  db_username         = var.db_username
  db_password         = var.db_password
  security_group_ids  = var.security_group_ids
}