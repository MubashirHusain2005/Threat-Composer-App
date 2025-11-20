terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.20.0"
    }
  }

}
provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket   = "mubashir-tf-state-bucket"
    key      = "terraform.tfstate"
    region   = "terraform-locks"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

  resource "aws_s3_bucket" "tf_state" {
  bucket = "mubashir-tf-state-bucket"

    tags = {
      Name = "tf-S3"
      Environment = "DEV"
    }
}

resource "aws_dynamodb_table" "tf_lock" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}




