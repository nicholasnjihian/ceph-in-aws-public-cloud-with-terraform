variable "instance_type" {
        default = {
                mon = "t2.medium"
                osd  = "t2.xlarge"
        }
}

variable "private_mon1_ip" {
  description = "Private IP address for mon1. (must be under the subnet_cidr_block)"
 type = string
}

variable "private_mon2_ip" {
  description = "Private IP address for mon2. (must be under the subnet_cidr_block)"
  type = string
}

#variable "private_mon3_ip" {
#  description = "Private IP address for mon3. (must be under the subnet_cidr_block)"
#  type = string
#}

variable "private_osd1_ip" {
  description = "Private IP address for osd1. (must be under the subnet_cidr_block)"
  type = string
}

variable "private_osd2_ip" {
  description = "Private IP address for osd2. (must be under the subnet_cidr_block)"
  type = string
}

variable "private_osd3_ip" {
  description = "Private IP address for osd3. (must be under the subnet_cidr_block)"
  type = string
}

variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  type = string
}

variable "ceph_sg" {
  description = <<-EOT
Ceph security group with various rules such as ssh access,
ICMP pings and access to ports 80 & 443 for package installation and updates.
EOT
  type = any
}

variable "vpc_az1" {
  description = "Availability zone"
  type = string
}
variable "vpc_az2" {
  description = "Availability zone"
  type = string
}
variable "vpc_az3" {
  description = "Availability zone"
  type = string
}

variable "vpc_priv_subnet" {
  description = "ID for a private subnet in our VPC"
  type = any
}

variable "vpc_pub_subnet" {
  description = "ID for a public subnet in our VPC"
  type = any
}

