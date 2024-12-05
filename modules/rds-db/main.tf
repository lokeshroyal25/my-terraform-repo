resource "aws_db_instance" "example" {
  identifier              = var.identifier
  engine                  = var.db_engine
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage
  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password
  skip_final_snapshot     = true
  publicly_accessible     = true
  vpc_security_group_ids  = var.security_group_ids
}