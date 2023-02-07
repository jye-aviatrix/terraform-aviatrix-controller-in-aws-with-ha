# Create VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

# Create IGW
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.vpc_name
  }
}

# Create route table for controller
resource "aws_route_table" "aviatrix" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.vpc_name}-Public-Controller"
  }
}

# Create route table for spoke gateways
resource "aws_route_table" "spoke_gw" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.vpc_name}-Public-Spoke-GW"
  }
}
# Create route table for spoke gateways
resource "aws_route_table" "ilb" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_name}-Private-ILB"
  }
}

# Create subnets for controller
resource "aws_subnet" "aviatrix_subnets" {
  vpc_id     = aws_vpc.main.id
  count = length(var.vpc_azs)
  cidr_block = var.aviatrix_subnets[count.index]

  tags = {
    Name = "${var.vpc_name}-Public-Controller-${var.vpc_azs[count.index]}"
  }
}

# Create subnets for spoke gws
resource "aws_subnet" "spoke_gw_subnets" {
  vpc_id     = aws_vpc.main.id
  count = length(var.vpc_azs)
  cidr_block = var.spoke_gw_subnets[count.index]

  tags = {
    Name = "${var.vpc_name}-Public-Spoke-GW-${var.vpc_azs[count.index]}"
  }
}

# Create subnets for ILB
resource "aws_subnet" "ilb_subnets" {
  vpc_id     = aws_vpc.main.id
  count = length(var.vpc_azs)
  cidr_block = var.ilb_subnets[count.index]

  tags = {
    Name = "${var.vpc_name}-Private-ILB-${var.vpc_azs[count.index]}"
  }
}

# Associate Aviatrix Controller route table
resource "aws_route_table_association" "aviatrix" {
  count = length(var.vpc_azs)
  subnet_id      = aws_subnet.aviatrix_subnets[count.index].id
  route_table_id = aws_route_table.aviatrix.id
}

# Associate Spoke GW route table
resource "aws_route_table_association" "spoke_gw" {
  count = length(var.vpc_azs)
  subnet_id      = aws_subnet.spoke_gw_subnets[count.index].id
  route_table_id = aws_route_table.spoke_gw.id
}

# Associate ILB route table
resource "aws_route_table_association" "ilb" {
  count = length(var.vpc_azs)
  subnet_id      = aws_subnet.ilb_subnets[count.index].id
  route_table_id = aws_route_table.ilb.id
}