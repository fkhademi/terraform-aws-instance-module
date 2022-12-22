output "vm" {
  description = "The created VM as an object with all of it's attributes. This was created using the aws_instance resource."
  value       = aws_instance.default
}

output "key" {
  description = "The created SSH Key as an object with all of it's attributes. This was created using the aws_key_pair resource."
  value       = aws_key_pair.default
}

output "sg" {
  description = "The created Security Group as an object with all of it's attributes. This was created using the aws_security_group resource."
  value       = aws_security_group.default
}

output "eip" {
  count       = var.public_ip ? 1 : 0
  description = "The created EIP as an object with all of it's attributes. This was created using the aws_eip resource."
  value       = aws_eip.default
}