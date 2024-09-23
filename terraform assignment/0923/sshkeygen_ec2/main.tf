provider "aws" {
  profile = "master-programmatic-admin"
  region  = "ap-northeast-1"
}

module "keypair" {
  source          = "./modules/key_pair"
  deployment_name = "helloCloud-sshkey"
}

module "vpc" {
  source                      = "./modules/vpc"
  vpc_primary_cidr            = "192.168.0.0/16"
  subnet_cidr_block_public_1a = "192.168.0.0/20"
}

module "ec2" {
  source            = "./modules/ec2"
  # this ami might be different in your region
  instance_ami     = "ami-09ebacdc178ae23b7"
  subnet_id         = module.vpc.subnet_id
  key_pair_name     = module.keypair.aws_key_pair_name
  security_group_id = module.vpc.security_group_id
}