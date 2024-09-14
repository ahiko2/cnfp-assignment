terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.66.0"
    }
  }
  # backend "s3" {
  #   bucket = "elli-terraform-backend"
  #   key    = "terraform.tfstate"
  #   region = "ap-northeast-1"
  #   dynamodb_table = "dynamo-DB"
  # }
}

provider "aws" {
  region = "ap-northeast-1"
}

