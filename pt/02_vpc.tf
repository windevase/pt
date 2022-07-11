provider "aws" {
  region = var.region.region
  # access_key = ""
  # secret_key = ""
}

resource "aws_vpc" "vpc" {    
  cidr_block = var.cidr.vpc
  enable_dns_hostnames = true 
  enable_dns_support = true
  tags = {
    "Name" = "${format("%s-vpc", var.name)}"
  }
}