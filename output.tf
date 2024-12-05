output "s3_bucket_name" {
  value = module.s3.s3_bucket_name
}

output "static_website_url" {
  value = module.static_website.website_url
}

output "rds_endpoint" {
  value = module.rds.db_endpoint
}