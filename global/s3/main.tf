provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "terra-forma-juanjo-3001"

  lifecycle {
    prevent_destroy = true
  }
}

# resource "aws_s3_bucket_versioning" "default"

resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.terraform_state.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# resource "aws_s3_bucket_public_access_block" "public_access"

resource "aws_dynamodb_table" "terraform_locks" {
  name = "terra-forma-juanjo-3001-locks"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  billing_mode = "PAY_PER_REQUEST"
}
