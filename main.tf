provider "aws" {
  region = "us-east-1"
}


module "vpc" {
  source                           = "modules/vpc"

  sdn_name                         = "${var.sdn_name}"
  cidr_block                       = "173.0.0.0/16"
  tenancy                          = "default" 	#A tenancy option for instances launched into the VPC.
  enable_dns_support               = "false"   	#A boolean flag to enable/disable DNS support in the VPC. Defaults true.
  enable_dns_hostnames             = "false"	#A boolean flag to enable/disable DNS hostnames in the VPC. Defaults false.
  enable_classiclink               = "false"	#A boolean flag to enable/disable ClassicLink for the VPC. Defaults false.
  assign_generated_ipv6_cidr_block = "false"
  subnet_cidr                      = "173.0.1.0/24"
  availability_zone                = "us-east-1a"
  map_public_ip_on_launch          = "false"
  assign_ipv6_address_on_creation  = "false"
}

module "ec2" {
  source                               = "modules/ec2"

  sdn_name                             = "${var.sdn_name}"
  instance_type                        = "t2.micro"
  disable_api_termination              = "false"	#If true, enables EC2 Instance Termination Protection
  instance_initiated_shutdown_behavior = "stop" 
  key_name                             = ""
  monitoring                           = "false" 	#If true, the launched EC2 instance will have detailed monitoring enabled
  subnet_id                            = "${module.vpc.subnet_id}"
  associate_public_ip_address          = "true"		#Associate a public ip address with an instance in a VPC. Boolean value.
}


