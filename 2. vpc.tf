provider "aws" {
  region = "ap-northeast-2"
  # access_key = "AKIATPYPWNE3P7C7Z6HN"
  # secret_key = "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"
  }

resource "aws_vpc" "hjko_vpc" {    
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true 
  enable_dns_support = true
  tags = {
    "Name" = "hjko-vpc"
  }
}