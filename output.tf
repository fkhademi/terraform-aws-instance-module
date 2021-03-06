output "vm" {
  description = "The created VM as an object with all of it's attributes. This was created using the aws_instance resource."
  value       = aws_instance.instance
}

output "key" {
  description = "The created SSH Key as an object with all of it's attributes. This was created using the aws_key_pair resource."
  value       = aws_key_pair.key
}

output "sg" {
  description = "The created Security Group as an object with all of it's attributes. This was created using the aws_security_group resource."
  value       = aws_security_group.sg
}
