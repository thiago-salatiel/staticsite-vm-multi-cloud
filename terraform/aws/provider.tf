terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.23"
    }
  }
  backend "s3" {
    bucket         = "tfstate-vm-multi-cloud"
    key            = "terraform.tfstate"
    dynamodb_table = "terraform_state"
    region         = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}