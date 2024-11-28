# main.tf
provider "aws" {
  region = "us-east-1"  # Change this to your preferred region
}

resource "aws_db_instance" "example" {
  identifier        = "mydb-instance"
  engine            = var.db_engine
  instance_class    = var.db_instance_class
  allocated_storage = var.db_allocated_storage
  db_name              = var.db_name
  username          = var.db_username
  password          = var.db_password
  skip_final_snapshot = true
  publicly_accessible = true

  # Security groups to allow access to the database
  vpc_security_group_ids = ["sg-12345678"]  # Replace with your security group ID

  tags = {
    Name = "MyRDSInstance"
  }
}

output "db_endpoint" {
  value = aws_db_instance.example.endpoint
}
