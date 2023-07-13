variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  type        = string
}

variable "region" {
  description = "AWS region"
  default     = "us-east-1"
  type        = string
}

variable "access_key" {
  description = "AWS access key"
  type        = string
}

variable "secret_key" {
  description = "AWS secret access key"
  type        = string
}

variable "cidr_block" {
  description = "VPC CIDR block."
  type        = string
}

#variable "public_subnet_cidr_block" {
#  description = "Public CIDR block for Ceph subnet."
#  type        = string
#}
#
#variable "private_subnet_cidr_block" {
#  description = "Private CIDR block for Ceph subnet."
#  type        = string
#}


variable "private_mon1_ip" {
  description = "Private IP address for mon1. (must be under the subnet_cidr_block)"
  type        = string
}

variable "private_mon2_ip" {
  description = "Private IP address for mon2. (must be under the subnet_cidr_block)"
  type        = string
}

#variable "private_mon3_ip" {
#  description = "Private IP address for mon3. (must be under the subnet_cidr_block)"
#  type        = string
#}

variable "private_osd1_ip" {
  description = "Private IP address for osd1. (must be under the subnet_cidr_block)"
  type        = string
}

variable "private_osd2_ip" {
  description = "Private IP address for osd2. (must be under the subnet_cidr_block)"
  type        = string
}

variable "private_osd3_ip" {
  description = "Private IP address for osd3. (must be under the subnet_cidr_block)"
  type        = string
}

variable "instance_type" {
  default = {
    mon = "t2.medium"
    osd = "t2.xlarge"
  }
}

