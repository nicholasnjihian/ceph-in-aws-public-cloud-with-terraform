output "mon1_elastic_ip" {
  value = aws_eip.mon1-eip.public_ip
}
output "mon2_elastic_ip" {
  value = aws_eip.mon2-eip.public_ip
}
#output "mon3_elastic_ip" {
#  value = aws_eip.mon3-eip.public_ip
#}
output "osd1_elastic_ip" {
  value = aws_eip.osd1-eip.public_ip
}
output "osd2_elastic_ip" {
  value = aws_eip.osd2-eip.public_ip
}
output "osd3_elastic_ip" {
  value = aws_eip.osd3-eip.public_ip
}


output "ceph_security_group" {
  value =  {
    name = module.ceph_sec_grp.security_group_name
    id   = module.ceph_sec_grp.security_group_id
    arn  = module.ceph_sec_grp.security_group_arn
  }
}

output "vpc_az" {
  value = {
    az1 = module.vpc.azs[0]
    az2 = module.vpc.azs[1]
    az3 = module.vpc.azs[2]
  }
}


output "vpc_subnets" {
  value = {
    priv_subnet_ids = module.vpc.private_subnets
    pub_subnet_ids = module.vpc.public_subnets
    priv_subnet_cidrs = module.vpc.private_subnets_cidr_blocks
    pub_subnet_cidrs = module.vpc.public_subnets_cidr_blocks
  }
}
