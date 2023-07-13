variable "namespace" {
  description = "The project namespace to use for unique resource naming"
  type = string
}

variable "aws_instance_osd1_id" {
  description = "OSD osd1 aws instance ID"
}

variable "aws_instance_osd2_id" {
  description = "OSD osd2 aws instance ID"
}

variable "aws_instance_osd3_id" {
  description = "OSD osd3 aws instance ID"
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


