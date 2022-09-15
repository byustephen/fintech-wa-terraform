#  ███╗   ███╗ █████╗ ██╗███╗   ██╗
#  ████╗ ████║██╔══██╗██║████╗  ██║
#  ██╔████╔██║███████║██║██╔██╗ ██║
#  ██║╚██╔╝██║██╔══██║██║██║╚██╗██║
#  ██║ ╚═╝ ██║██║  ██║██║██║ ╚████║
#  ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝
#                                                      

#VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name              = var.vpc_name
  }
}

#Subnets (We could set this up as a loop if we wanted to get fancy). 
resource "aws_subnet" "subnet-a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidrs[0]
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet A"
  }
}

resource "aws_subnet" "subnet-b" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidrs[1]
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet B"
  }
}

resource "aws_subnet" "subnet-c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidrs[2]
  availability_zone = "us-west-2c"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet C"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "primary-gateway" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Primary"
  }
}

resource "aws_eip" "primary-eip-nat" {
  tags = {
    Name = "Primary - Nat"
  }
}

#Nat gateway
resource "aws_nat_gateway" "primary-nat" {
  allocation_id = aws_eip.primary-eip-nat.id
  subnet_id     = aws_subnet.subnet-a.id
  connectivity_type = "public"
  
  tags = {
    Name = "Primary NAT"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.primary-gateway]
}

#Public Route Table
resource "aws_route_table" "primary-public-route-table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.primary-gateway.id
  }

  tags = {
    Name = "Primary - Public Route Table"
  }
}

#Private Route Table
resource "aws_route_table" "primary-private-route-table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.primary-nat.id
  }

  tags = {
    Name = "Primary - Private Route Table"
  }
}

#Route table Associations
resource "aws_route_table_association" "primary-public-route-table-association-a" {
  subnet_id      = aws_subnet.subnet-a.id
  route_table_id = aws_route_table.primary-public-route-table.id
}

resource "aws_route_table_association" "primary-public-route-table-association-b" {
  subnet_id      = aws_subnet.subnet-b.id
  route_table_id = aws_route_table.primary-public-route-table.id
}

resource "aws_route_table_association" "primary-private-route-table-association" {
  subnet_id      = aws_subnet.subnet-c.id
  route_table_id = aws_route_table.primary-private-route-table.id
}


