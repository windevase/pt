provider "aws" {
  region = "ap-northeast-2"
}

data "aws_vpc" "owner" {
  cidr_block       = "10.0.0.0/16"
}

data "aws_vpc" "recipient" {
  cidr_block       = "10.1.0.0/16"
}


############################# peering ###############################################


data "aws_caller_identity" "current" {} # 자기 aws id


resource "aws_vpc_peering_connection" "vpc_peering" {
  peer_owner_id = data.aws_caller_identity.current.id
  peer_vpc_id   = data.aws_vpc.owner.id
  vpc_id        = data.aws_vpc.recipient.id
  auto_accept   = true

  tags = {
    Name = "VPC Peering"
  }
}


data "aws_route_tables" "owner" {
  vpc_id   = data.aws_vpc.owner.id
}

data "aws_route_tables" "recipient" {
  vpc_id   = data.aws_vpc.recipient.id
}

# output name {
#   value       = tolist(data.aws_route_tables.owner.ids)[0]
# }
# output name2 {
#   value       = length(data.aws_route_tables.owner.ids)
# }


resource "aws_route" "r1" {
  count                     = length(data.aws_route_tables.owner.ids)
  route_table_id            = tolist(data.aws_route_tables.owner.ids)[count.index]
  destination_cidr_block    = data.aws_vpc.recipient.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}

resource "aws_route" "r2" {
  count                     = length(data.aws_route_tables.recipient.ids)
  route_table_id            = tolist(data.aws_route_tables.recipient.ids)[count.index]//aws_route_table.pub-a.id
  destination_cidr_block    = data.aws_vpc.owner.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc_peering.id
}