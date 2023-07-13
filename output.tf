output "mon1_public_ip" {
  value =  module.networking.mon1_elastic_ip
}

output "mon2_public_ip" {
  value = module.networking.mon2_elastic_ip
}

output "osd1_public_ip" {
  value = module.networking.osd1_elastic_ip
}

output "osd2_public_ip" {
  value = module.networking.osd2_elastic_ip
}

output "osd3_public_ip" {
  value = module.networking.osd3_elastic_ip
}
