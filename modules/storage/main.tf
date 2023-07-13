resource "aws_ebs_volume" "osd1_ebs" {
  availability_zone = var.vpc_az1
  size = 100

  tags = {
    Name = "osd1_dev"
  }
}

resource "aws_ebs_volume" "osd2_ebs" {
  availability_zone = var.vpc_az2
  size = 100

  tags = {
    Name = "osd2_dev"
  }
}

resource "aws_ebs_volume" "osd3_ebs" {
  availability_zone = var.vpc_az3
  size = 100

  tags = {
    Name = "osd3_dev"
  }
}

resource "aws_volume_attachment" "ebs_osd1_attach" {
  device_name = "/dev/sdd"
  volume_id   = aws_ebs_volume.osd1_ebs.id
  instance_id = var.aws_instance_osd1_id
}

resource "aws_volume_attachment" "ebs_osd2_attach" {
  device_name = "/dev/sdd"
  volume_id   = aws_ebs_volume.osd2_ebs.id
  instance_id = var.aws_instance_osd2_id
}

resource "aws_volume_attachment" "ebs_osd3_attach" {
  device_name = "/dev/sdd"
  volume_id   = aws_ebs_volume.osd3_ebs.id
  instance_id = var.aws_instance_osd3_id
}
