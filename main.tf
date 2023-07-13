module "networking" {
  source     = "./modules/networking"
  namespace  = var.namespace
  cidr_block = var.cidr_block
  #private_subnet_cidr_block = var.private_subnet_cidr_block
  #public_subnet_cidr_block  = var.public_subnet_cidr_block

  aws_instance_mon1_id = module.ceph.aws_instance_mon1_id
  aws_instance_mon2_id = module.ceph.aws_instance_mon2_id

  aws_instance_osd1_id = module.ceph.aws_instance_osd1_id
  aws_instance_osd2_id = module.ceph.aws_instance_osd2_id
  aws_instance_osd3_id = module.ceph.aws_instance_osd3_id
}

module "ceph" {
  source             = "./modules/ceph"
  namespace          = var.namespace
  private_mon1_ip    = var.private_mon1_ip
  private_mon2_ip    = var.private_mon2_ip
  private_osd1_ip    = var.private_osd1_ip
  private_osd2_ip    = var.private_osd2_ip
  private_osd3_ip    = var.private_osd3_ip
  instance_type      = var.instance_type
  ceph_sg            = module.networking.ceph_security_group.id
  vpc_az1            = module.networking.vpc_az.az1
  vpc_az2            = module.networking.vpc_az.az2
  vpc_az3            = module.networking.vpc_az.az3
  vpc_priv_subnet = module.networking.vpc_subnets.priv_subnet_ids
  vpc_pub_subnet  = module.networking.vpc_subnets.pub_subnet_ids
}

module "storage" {
  source               = "./modules/storage"
  namespace            = var.namespace
  vpc_az1              = module.networking.vpc_az.az1
  vpc_az2              = module.networking.vpc_az.az2
  vpc_az3              = module.networking.vpc_az.az3
  aws_instance_osd1_id = module.ceph.aws_instance_osd1_id
  aws_instance_osd2_id = module.ceph.aws_instance_osd2_id
  aws_instance_osd3_id = module.ceph.aws_instance_osd3_id
}
