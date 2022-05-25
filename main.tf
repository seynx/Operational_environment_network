# always start with locals at the top
#local are used to get rid of dedundancy
locals {
  mandatory_tag = {
    line_of_business        = "hospital"
    ado                     = "max"
    tier                    = "WEB"
    operational_environment = upper(terraform.workspace)
    tech_poc_primary        = "udu.udu25@gmail.com"
    tech_poc_secondary      = "udu.udu25@gmail.com"
    application             = "http"
    builder                 = "udu.udu25@gmail.com"
    application_owner       = "kojitechs.com"
    vpc                     = "WEB"
    cell_name               = "WEB"
    component_name          = "kojitechs"
  }
  vpc_id = aws_vpc.kojitechs_vpc.id
}

data "aws_availability_zones" "azs" {
  state = "available"
}

#create a VPC

resource "aws_vpc" "kojitechs_vpc" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true #passing because we need to enable nat gateway
  enable_dns_support   = true #passing because we need to enable nat gateway

  tags = {
    Name = "kojitechs_vpc"
  }
}

#create a vpc public_subnet

resource "aws_subnet" "pub_subnet_1" {
  vpc_id                  = local.vpc_id
  cidr_block              = var.pub_subnet_cidr[0]
  availability_zone       = data.aws_availability_zones.azs.names[0] #we are using datasource here
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_subnet_1"
  }
}
resource "aws_subnet" "pub_subnet_2" {
  vpc_id                  = local.vpc_id
  cidr_block              = var.pub_subnet_cidr[1]
  availability_zone       = data.aws_availability_zones.azs.names[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "pub_subnet_2"
  }
}
#create a vpc private_subnet

resource "aws_subnet" "priv_subnet_1" {
  vpc_id            = local.vpc_id
  cidr_block        = var.priv_subnet_cidr[0]
  availability_zone = data.aws_availability_zones.azs.names[0]

  tags = {
    Name = "priv_sub_${data.aws_availability_zones.azs.names[0]}"
  }
}
resource "aws_subnet" "priv_subnet_2" {
  vpc_id            = local.vpc_id
  cidr_block        = var.priv_subnet_cidr[1]
  availability_zone = data.aws_availability_zones.azs.names[1]

  tags = {
    Name = "priv_sub_${data.aws_availability_zones.azs.names[1]}"
  }
}
#create a vpc private_database_subnet

resource "aws_subnet" "database_subnet_1" {
  vpc_id            = local.vpc_id
  cidr_block        = var.priv_database_subnet_cidr[0]
  availability_zone = data.aws_availability_zones.azs.names[0]

  tags = {
    Name = "database_subnet_${data.aws_availability_zones.azs.names[0]}"
  }
}
resource "aws_subnet" "database_subnet_2" {
  vpc_id            = local.vpc_id
  cidr_block        = var.priv_database_subnet_cidr[1]
  availability_zone = data.aws_availability_zones.azs.names[1]
  
  tags = {
    Name = "database_subnet_${data.aws_availability_zones.azs.names[1]}"
  }
}