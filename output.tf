output "vm" {
  description = "The created VM as an object with all of it's attributes. This was created using the aws_instance resource."
  value       = aws_instance.default
}

output "key" {
  description = "The created SSH Key as an object with all of it's attributes. This was created using the aws_key_pair resource."
  value       = aws_key_pair.default
}

output "lan_nic" {
  description = "The LAN Network Interface resource."
  value       = aws_network_interface.lan
}

output "wan_nic" {
  description = "The WAN Network Interface resource."
  value       = aws_network_interface.wan
}

output "eip" {
  #count       = var.public_ip ? 1 : 0
  description = "The created EIP as an object with all of it's attributes. This was created using the aws_eip resource."
  value       = aws_eip.default[0] #var.public_ip ? aws_eip.default.public_ip : null
}
