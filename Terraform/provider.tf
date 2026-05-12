terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.20.0"
    }
  }


  backend "s3" {
    bucket       = "mubashir-tf-state-bucket-20-11-2025"
    key          = "terraform.tfstate"
    region       = "eu-west-2"
    use_lockfile = true
    encrypt      = true

  }
}

provider "aws" {
  region = "eu-west-2"
}






