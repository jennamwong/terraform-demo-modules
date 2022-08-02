provider "aws" {
  region = "us-west-2"

  default_tags {
    tags = {
      hashicorp-learn = "module-use"
    }
  }
}


# This module has 23 required inputs 
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc" { 
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags
}


# This module has no required inputs 
# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/4.1.1
module "ec2_instances" { 
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.5.0"
  count   = 2

  name = "my-ec2-cluster"

  ami                    = "ami-0c5204531f799e0c6"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}


# module "website_s3_bucket" {
#   source = "./modules/aws-s3-static-website-bucket"

#   bucket_name = "jennas-bucket"

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }

module "website-s3-bucket" {
  source  = "app.terraform.io/hashicorp-jennawong/website-s3-bucket/aws"
  version = "1.0.0"
  # insert required variables here

  bucket_name = "jennas-bucket"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}