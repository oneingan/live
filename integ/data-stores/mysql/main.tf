provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "terra-forma-juanjo-3001"
    # 1:1 mapeo organizacion directorios
    key = "integ/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terra-forma-juanjo-3001-locks"
    encrypt = true
  }
}

resource "aws_db_instance" "example" {
  engine = "mysql"
  engine_version = "5.7"
  allocated_storage = 10
  instance_class = "db.t2.micro"
  skip_final_snapshot = true
  db_name = "example_database"

  username = var.db_username
  password = var.db_password
}

