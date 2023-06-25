# Configuring VPC for Tenacity
resource "aws_vpc" "prod_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  enable_dns_support   = "true"
  tags = {
    name = "prod_vpc"
  }
}

# Create Public Subnet-1
resource "aws_subnet" "prod_public_subnet-1" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
  tags = {
    name = "prod_public_subnet-1"
  }
}

# Create Public Subnet-2
resource "aws_subnet" "prod_public_subnet-2" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2a"
  tags = {
    name = "prod_public_subnet-2"
  }
}

# Create Private Subnet-1
resource "aws_subnet" "prod_private_subnet-1" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-2b"
  tags = {
    name = "prod_public_subnet-1"
  }
}

# Create Private Subnet-2
resource "aws_subnet" "prod_private_subnet-2" {
  vpc_id            = aws_vpc.prod_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "eu-west-2b"
  tags = {
    name = "prod_public_subnet-2"
  }
}

# Create Public Route-Table
resource "aws_route_table" "prod_public_rt" {
  vpc_id = aws_vpc.prod_vpc.id
  tags = {
    name = "prod_public_rt"
  }
}

# Create Private Route-Table
resource "aws_route_table" "prod_private_rt" {
  vpc_id = aws_vpc.prod_vpc.id
  tags = {
    name = "prod_privte_rt"
  }
}

# Associate Public Subnet to Public Route_Table
resource "aws_route_table_association" "public_subnet-1_association" {
  subnet_id      = aws_subnet.prod_public_subnet-1.id
  route_table_id = aws_route_table.prod_public_rt.id
}

# Associate Public Subnet to Public Route_Table
resource "aws_route_table_association" "public_subnet-2_association" {
  subnet_id      = aws_subnet.prod_public_subnet-2.id
  route_table_id = aws_route_table.prod_public_rt.id
}

# Associate Private Subnet to Private Route_Table
resource "aws_route_table_association" "private_subnet-1_association" {
  subnet_id      = aws_subnet.prod_private_subnet-1.id
  route_table_id = aws_route_table.prod_private_rt.id
}

# Associate Private Subnet to Private Route_Table
resource "aws_route_table_association" "private_subnet-2_association" {
  subnet_id      = aws_subnet.prod_private_subnet-2.id
  route_table_id = aws_route_table.prod_private_rt.id
}

# Create Internet Gateway (IGW)
resource "aws_internet_gateway" "prod_igw" {
  vpc_id = aws_vpc.prod_vpc.id
  tags = {
    name : "prod_igw"
  }
}

# Associate IGW to Public Route Table 
resource "aws_route" "prod_igw" {
  route_table_id         = aws_route_table.prod_public_rt.id
  gateway_id             = aws_internet_gateway.prod_igw.id
  destination_cidr_block = "0.0.0.0/0"
}

# Allocate Elastic IP address
resource "aws_eip""eip_prod_nat_gateway" {
  vpc = true
  tags = {
    name = "eip"
  }
}

# Create Nat Gateway in Public Subnet-1
resource "aws_nat_gateway" "prod_nat_gateway" {
  allocation_id = aws_eip.eip_prod_nat_gateway.id
  subnet_id     =  aws_subnet.prod_public_subnet-1.id
  tags={
    name="prod.natgw"  
  }
}

# Associate Nat Gateway to Private Route 
resource "aws_route" "prod_private_rt"{
  route_table_id         = aws_route_table.prod_private_rt.id
  nat_gateway_id         = aws_nat_gateway.prod_nat_gateway.id
  destination_cidr_block = "0.0.0.0/0"
} 
