variable "identifier" {
  type = string
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
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "security_group_ids" {
  type = list(string)
}