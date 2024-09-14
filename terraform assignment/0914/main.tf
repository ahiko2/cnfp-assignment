module "s3" {
  source = "../modules/s3"
}

module "vpc" {
  source = "../modules/vpc"
}

module "dynamodb" {
  source = "../modules/dynamodb"
}