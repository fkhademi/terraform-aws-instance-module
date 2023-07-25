variable "name" {
  type = string
}

variable "region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "ssh_key" {
  type = string
}

variable "public_ip" {
  default = false
}

variable "instance_size" {
  type    = string
  default = "t2.micro"
}

variable "user_data" {
  default = ""
}

variable "ubuntu_version" {
  description = "Ubuntu version to deploy.  Use 18, 20 or 22"
  default     = "22"
}

variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [22, 80, 500, 4500]
}
