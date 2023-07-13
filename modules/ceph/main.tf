data "cloudinit_config" "config" {
  gzip = true
  base64_encode = true
  part {
    content_type = "text/cloud-config"
    content = file("${path.module}/../../scripts/cloud-config.yaml")
  }
}


data "aws_ami" "ubuntu" {
    most_recent = true
    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    }
    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
    owners = ["099720109477"]
}


module "aws_instance_mon1" {
  source                       = "terraform-aws-modules/ec2-instance/aws"
  name                         = "mon1"
  availability_zone            = var.vpc_az1
  ami                          = data.aws_ami.ubuntu.id
  user_data_base64             = data.cloudinit_config.config.rendered
  user_data_replace_on_change  = true
  instance_type                = "${var.instance_type.mon}"
  vpc_security_group_ids       = ["${var.ceph_sg}"]
 # private_ip                  = "${var.private_mon1_ip}"
  subnet_id                    = var.vpc_priv_subnet[0]
  associate_public_ip_address  = true
  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }

  tags = {
    Name = terraform.workspace
  }
}


module "aws_instance_mon2" {
  source                       = "terraform-aws-modules/ec2-instance/aws"
  name                         = "mon2"
  availability_zone            = var.vpc_az2
  ami                          = data.aws_ami.ubuntu.id
  user_data_base64             = data.cloudinit_config.config.rendered
  instance_type                = "${var.instance_type.mon}"
  vpc_security_group_ids       = ["${var.ceph_sg}"]
#  private_ip                  = "${var.private_mon2_ip}"
  subnet_id                    = var.vpc_priv_subnet[1]
  associate_public_ip_address  = true
  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }

  tags = {
    Name = terraform.workspace
  }
}

# AWS, by default, allows you to allocate at most 5 Elastic IPs per region.
# module "aws_instance_mon3" {
# source                        = "terraform-aws-modules/ec2-instance/aws"
#  availability_zone            = var.vpc_az3
#  ami                          = data.aws_ami.ubuntu.id
#  user_data_base64             = data.cloudinit_config.config.rendered
#  instance_type                = "${var.instance_type.mon}"
#  vpc_security_group_ids       = ["var.ceph_sg"]
#  private_ip                   = "${var.private_mon3_ip}"
#  subnet_id                    = var.vpc_priv_subnet[2]
#  associate_public_ip_address  =true
#
#  tags = {
#    Name = terraform.workspace
#  }
#}

module "aws_instance_osd1" {
  source                       = "terraform-aws-modules/ec2-instance/aws"
  name                         = "osd1"
  availability_zone            = var.vpc_az1
  ami                          = data.aws_ami.ubuntu.id
  user_data_base64             = data.cloudinit_config.config.rendered
  instance_type                = "${var.instance_type.osd}"
  vpc_security_group_ids       = ["${var.ceph_sg}"]
 # private_ip                  = "${var.private_osd1_ip}"
  subnet_id                    = var.vpc_priv_subnet[0]
  associate_public_ip_address  = true
  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }
  tags = {
    Name = terraform.workspace
  }
}


module "aws_instance_osd2" {
  source                       = "terraform-aws-modules/ec2-instance/aws"
  name                         = "osd2"
  availability_zone            = var.vpc_az2
  ami                          = data.aws_ami.ubuntu.id
  user_data_base64             = data.cloudinit_config.config.rendered
  instance_type                = "${var.instance_type.osd}"
  vpc_security_group_ids       = ["${var.ceph_sg}"]
 # private_ip                  = "${var.private_osd2_ip}"
  subnet_id                    = var.vpc_priv_subnet[1]
  associate_public_ip_address  = true
  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }
  tags = {
    Name = terraform.workspace
  }
}


module "aws_instance_osd3" {
  source                       = "terraform-aws-modules/ec2-instance/aws"
  name                         = "osd3"
  availability_zone            = var.vpc_az3
  ami                          = data.aws_ami.ubuntu.id
  user_data_base64             = data.cloudinit_config.config.rendered
  instance_type                = "${var.instance_type.osd}"
  vpc_security_group_ids       = ["${var.ceph_sg}"]
 # private_ip                  = "${var.private_osd3_ip}"
  subnet_id                    = var.vpc_priv_subnet[2]
  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 instance"
  iam_role_policies = {
    AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
  }
  associate_public_ip_address  = true
  tags = {
    Name = terraform.workspace
  }
}

