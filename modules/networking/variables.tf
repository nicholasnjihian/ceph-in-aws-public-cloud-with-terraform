variable "namespace" {
    type = string
}

variable "cidr_block" {
  description = "VPC CIDR block."
  type = string
}

#variable "private_subnet_cidr_block" {
#  description = "Private CIDR block for Ceph subnet."
#  type = string
#}
#
#variable "public_subnet_cidr_block" {
#  description = "Public CIDR block for Ceph subnet."
#  type        = string
#}

variable "aws_instance_mon1_id" {
  description = "Ceph MON mon1 AWS VM Instance ID"
}
variable "aws_instance_mon2_id" {
  description = "Ceph MON mon2 AWS VM Instance ID"
}
#variable "aws_instance_mon3_id" {
#  description = "Ceph MON mon3 AWS VM Instance ID"
#}
variable "aws_instance_osd1_id" {
  description = "Ceph OSD osd1 AWS VM Instance ID"
}
variable "aws_instance_osd2_id" {
  description = "Ceph OSD osd2 AWS VM Instance ID"
}
variable "aws_instance_osd3_id" {
  description = "Ceph OSD osd3 AWS VM Instance ID"
}

