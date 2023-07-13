data "aws_availability_zones" "available" {}


################################################################################
# VPC Module
# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
# https://github.com/terraform-aws-modules/terraform-aws-vpc
################################################################################


locals {
  name = "${var.namespace}-vpc"
  vpc_cidr = var.cidr_block
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
}


module "vpc" {
  source                 = "terraform-aws-modules/vpc/aws"
  name                   = local.name
  cidr                   = local.vpc_cidr
  azs                    = local.azs
  private_subnets        = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  public_subnets         = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 4)]
  enable_nat_gateway     = false
  enable_vpn_gateway     = false
  enable_dns_hostnames   = true
  enable_dns_support     = true
  vpc_tags = {
    Name =  "${var.namespace}-vpc"
    Resource = "ceph env VPC"
  }
  tags = {
    Terraform = "true"
    Environment = "Ceph dev"
  }
}



################################################################################
# Using AWS EC2 Security Group Terraform Module:
# https://github.com/terraform-aws-modules/terraform-aws-security-group
################################################################################


module "ceph_sec_grp" {
  source = "terraform-aws-modules/security-group/aws"
  name =  "ceph_sec_grp"
  ingress_cidr_blocks = ["10.10.0.0/16"]

  vpc_id = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "ssh access"
      cidr_blocks = "196.216.86.75/32"
    },
    {
      from_port        = 8
      to_port          = 0
      protocol         = "icmp"
      description      = "Allow ping from 196.216.86.75"
      cidr_blocks      = "196.216.86.75/32"
    }
  ]
  egress_with_cidr_blocks = [
    {
      rule        = "https-443-tcp"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = 0
      to_port     = 0
      protocol    = -1
      description = "Allow egress HTTP Port access"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}


#Create an Elastic IP
resource "aws_eip" "mon1-eip" {}
resource "aws_eip" "mon2-eip" {}
#resource "aws_eip" "mon3-eip" {
#  depends_on = [var.aws_instance_mon3_id]
#  vpc = true
#}
resource "aws_eip" "osd1-eip" {}
resource "aws_eip" "osd2-eip" {}
resource "aws_eip" "osd3-eip" {}



#Associate EIP with EC2 Instance

resource "aws_eip_association" "mon1-eip-association" {
  instance_id   = var.aws_instance_mon1_id
  allocation_id = aws_eip.mon1-eip.id
}
resource "aws_eip_association" "mon2-eip-association" {
  instance_id   = var.aws_instance_mon2_id
  allocation_id = aws_eip.mon2-eip.id
}
#resource "aws_eip_association" "mon3-eip-association" {
#  instance_id   = var.aws_instance_mon3_id
#  allocation_id = aws_eip.mon3-eip.id
#}
resource "aws_eip_association" "osd1-eip-association" {
  instance_id   = var.aws_instance_osd1_id
  allocation_id = aws_eip.osd1-eip.id
}
resource "aws_eip_association" "osd2-eip-association" {
  instance_id   = var.aws_instance_osd2_id
  allocation_id = aws_eip.osd2-eip.id
}
resource "aws_eip_association" "osd3-eip-association" {
  instance_id   = var.aws_instance_osd3_id
  allocation_id = aws_eip.osd3-eip.id
}

# The module "terraform-aws-modules/vpc/aws" automatically creates a resource "aws_internet_gateway". 
# So trying to create your own resource "aws_internet_gateway" fails.
# However, you can set the input `create_igw` to false
# (https://github.com/terraform-aws-modules/terraform-aws-vpc/blob/master/variables.tf).

## Internet Gateway for Public Subnet
#resource "aws_internet_gateway" "internet_gateway" {
#  vpc_id = module.vpc.vpc_id
#}
#
#
## Public subnet
#resource "aws_subnet" "public_subnet" {
#  vpc_id                  = module.vpc.vpc_id
#  cidr_block              = var.public_subnet_cidr_block
#  availability_zone       = var.subnet_availability_zone
#  map_public_ip_on_launch = true
#}
#
#
## Private Subnet
#resource "aws_subnet" "private_subnet" {
#  vpc_id                  = module.vpc.vpc_id
#  cidr_block              = var.private_subnet_cidr_block
#  availability_zone       = var.subnet_availability_zone
#  map_public_ip_on_launch = false
#}
#
#
## Routing tables to route traffic for Private Subnet
#resource "aws_route_table" "private" {
#  vpc_id = module.vpc.vpc_id
#}
#
#
## Routing tables to route traffic for Public Subnet
#resource "aws_route_table" "public" {
#  vpc_id = module.vpc.vpc_id
#}
#
#
## Route for Internet Gateway
#resource "aws_route" "public_internet_gateway" {
#  route_table_id         = aws_route_table.public.id
#  destination_cidr_block = "0.0.0.0/0"
#  gateway_id             = aws_internet_gateway.internet_gateway.id
#}
