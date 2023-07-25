### Description
Generic terraform module for deploying Linux VM, ssh key and sec group in AWS

### Usage Example
```
module "srv1" {
  source        = "git::https://github.com/fkhademi/terraform-aws-instance-module.git"

  name		= "frey"
  region	= "eu-central-1"
  vpc_id	= "vpc-05f81363c2a863c73"
  subnet_id	= "subnet-0f04ced572601947d"
  ssh_key	= var.ssh_key
}
```

### Variables
The following variables are required:

key | value
:--- | :---
name | AWS resource name
region | AWS region to deploy resources
vpc_id | VPC ID to deploy resources
subnet_id | Subnet ID to deploy EC2 instance
ssh_key | Public key to be used

The following variables are optional:

key | default | value 
:---|:---|:---
instance_size | t2.micro | The size of the EC2 instance
public_ip | false | Set to true to assign a public IP to the instance
user_data | | User data to pass to the instance
ubuntu_version | 22 | Ubuntu version to deploy (18, 20 or 22)
ingress_ports | 22, 80, 500, 4500 | List of ports to open on the WAN interface

### Outputs
This module will return the following outputs:

key | description
:---|:---
vm | The created VM as an object with all of it's attributes. This was created using the aws_instance resource.
key | The created SSH Key as an object with all of it's attributes. This was created using the aws_key_pair resource.
sg | The created Security Group as an object with all of it's attributes. This was created using the aws_security_group resource.
