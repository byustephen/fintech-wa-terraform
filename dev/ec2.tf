module "ec2" {
  source          = "../modules/ec2"
  vpc_cidr        = var.primary-vpc
  vpc_id          = "${module.vpc.vpc_id}"
  subnet_ids      = ["${module.vpc.subnet_a_id}","${module.vpc.subnet_b_id}","${module.vpc.subnet_c_id}"]
}