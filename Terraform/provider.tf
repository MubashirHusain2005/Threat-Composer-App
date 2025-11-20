terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.20.0"
    }
  }



 backend "s3" {
    bucket       = "mubashir-tf-state-bucket"
    key          = "terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = false
    encrypt      = true
    profile      = "terraform-test"
  }
}

provider "aws" {
  region = "eu-west-2"
}


resource "aws_s3_bucket" "tf_state" {
  bucket = "mubashir-tf-state-bucket"

  tags = {
    Name        = "tf-S3"
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




