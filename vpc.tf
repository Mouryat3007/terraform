
# vpc
resource "aws_vpc" "crm-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "crm-vpc"
  }
}


#websubnet
resource "aws_subnet" "web-sn" {
  vpc_id     = aws_vpc.crm-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "web-subnet"
  }
}
#apisubnet
resource "aws_subnet" "api-sn" {
  vpc_id     = aws_vpc.crm-vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "api-subnet"
  }
}
#databasesubent
resource "aws_subnet" "db-sn" {
  vpc_id     = aws_vpc.crm-vpc.id
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "database-subnet"
  }
}

#internet gateway
resource "aws_internet_gateway" "crm-igw" {
  vpc_id = aws_vpc.crm-vpc.id

  tags = {
    Name = "crm-internet-gateway"
  }
}

#public route table
resource "aws_route_table" "crm-pub-rt" {
  vpc_id = aws_vpc.crm-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.crm-igw.id
  }

  tags = {
    Name = "crm-public-route"
  }
}

#private route table
resource "aws_route_table" "crm-pvt-rt" {
  vpc_id = aws_vpc.crm-vpc.id

  tags = {
    Name = "crm-pvt-route"
  }
}

#crm public association
resource "aws_route_table_association" "crm-web-asc" {
  subnet_id      = aws_subnet.web-sn.id
  route_table_id = aws_route_table.rm-pub-rt.id
}

#crm public association
resource "aws_route_table_association" "crm-api-asc" {
  subnet_id      = aws_subnet.api-sn.id
  route_table_id = aws_route_table.rm-pub-rt.id
}

#crm private association
resource "aws_route_table_association" "crm-db-asc" {
  subnet_id      = aws_subnet.db-sn.id
  route_table_id = aws_route_table.crm-pvt-rt.id
}
