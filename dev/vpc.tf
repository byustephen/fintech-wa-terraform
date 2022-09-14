module "vpc" {
  source          = "../modules/vpc"
  vpc_cidr        = var.primary-vpc
  vpc_name        = "Primary"
  subnet_cidrs    = var.primary-subnets
}