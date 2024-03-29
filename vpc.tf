// AWS VPC - FortiGate
data "aws_vpc" "fgtvm-vpc" {
  id = ""
}

resource "aws_subnet" "publicsubnetaz1" {
  vpc_id            = data.aws_vpc.fgtvm-vpc.id
  cidr_block        = var.publiccidraz1
  availability_zone = var.az1
  tags = {
    Name = "fgt public subnet az1"
  }
}
//

resource "aws_subnet" "privatesubnetaz1" {
  vpc_id            = data.aws_vpc.fgtvm-vpc.id
  cidr_block        = var.privatecidraz1
  availability_zone = var.az1
  tags = {
    Name = "fgt private subnet az1"
  }
}

resource "aws_subnet" "transitsubnetaz1" {
  vpc_id            = data.aws_vpc.fgtvm-vpc.id
  cidr_block        = var.attachcidraz1
  availability_zone = var.az1
  tags = {
    Name = "fgt transit attach subnet az1"
  }
}

resource "aws_subnet" "gwlbsubnetaz1" {
  vpc_id            = data.aws_vpc.fgtvm-vpc.id
  cidr_block        = var.gwlbcidraz1
  availability_zone = var.az1
  tags = {
    Name = "fgt gwlb subnet az1"
  }
}
