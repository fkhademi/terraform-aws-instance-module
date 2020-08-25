### Description
Generic terraform for deploying Linux client in various clouds

### Usage Example
```
module "srv1" {
  source        = "git::https://github.com/fkhademi/terraform-aviatrix-linux-client.git"

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

### Outputs
This module will return the following outputs:

key | description
:---|:---
