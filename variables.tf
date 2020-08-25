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

variable "instance_size" {
  type    = string
  default = "t2.micro"
}