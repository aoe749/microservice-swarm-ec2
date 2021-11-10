# Create an internet gateway to give our subnet access to the outside world
resource "aws_internet_gateway" "swarm" {
  vpc_id = aws_vpc.swarm.id

  tags = {
    Owner       = "${var.owner}"
    Terraform   = true
    Environment = "${var.environment}"
    Name        = "swarm-igw"
  }
}

# Grant the VPC internet access on its main route table
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.swarm.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.swarm.id
}

# # Create Subnet
# resource "aws_subnet" "swarm" {
#   vpc_id     = aws_vpc.swarm.id
#   cidr_block = var.subnet_1_cidr
#   # availability_zone       = "eu-central-1a"
#   map_public_ip_on_launch = true
#
#   tags = {
#     Owner       = var.owner
#     Terraform   = true
#     Environment = var.environment
#     Name        = "swarm-subnet"
#   }
# }
# # Create Routing table to grant permission outbound for subnet 1
# resource "aws_route_table" "swarm" {
#   vpc_id = aws_vpc.swarm.id
#
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.swarm.id
#   }
#
#   tags = {
#     Owner       = var.owner
#     Terraform   = true
#     Environment = var.environment
#     Name        = "swarm-route-table"
#   }
# }
#
# # Associating routing table with subnet 1
# resource "aws_route_table_association" "swarm" {
#   subnet_id      = aws_subnet.swarm.id
#   route_table_id = aws_route_table.swarm.id
# }

# Create Subnet in the First AZ
resource "aws_subnet" "swarm_1" {
  vpc_id                  = aws_vpc.swarm.id
  cidr_block              = var.subnet_1_cidr
  availability_zone       = "eu-central-1a"
  map_public_ip_on_launch = true

  tags = {
    Owner       = var.owner
    Terraform   = true
    Environment = var.environment
    Name        = "swarm-subnet-1"
  }
}
# Create Routing table to grant permission outbound for subnet 1
resource "aws_route_table" "swarm_1" {
  vpc_id = aws_vpc.swarm.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.swarm.id
  }

  tags = {
    Owner       = var.owner
    Terraform   = true
    Environment = var.environment
    Name        = "swarm-route-table-swarm-1"
  }
}

# Associating routing table with subnet 1
resource "aws_route_table_association" "swarm_1" {
  subnet_id      = aws_subnet.swarm_1.id
  route_table_id = aws_route_table.swarm_1.id
}

# Create Subnet in the Second AZ
resource "aws_subnet" "swarm_2" {
  vpc_id                  = aws_vpc.swarm.id
  cidr_block              = var.subnet_2_cidr
  availability_zone       = "eu-central-1b"
  map_public_ip_on_launch = true

  tags = {
    Owner       = var.owner
    Terraform   = true
    Environment = var.environment
    Name        = "swarm-subnet-2"
  }
}
# Create Routing table to grant permission outbound for subnet 2
resource "aws_route_table" "swarm_2" {
  vpc_id = aws_vpc.swarm.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.swarm.id
  }

  tags = {
    Owner       = var.owner
    Terraform   = true
    Environment = var.environment
    Name        = "swarm-route-table-swarm-2"
  }
}

# Associating routing table with subnet 2
resource "aws_route_table_association" "swarm_2" {
  subnet_id      = aws_subnet.swarm_2.id
  route_table_id = aws_route_table.swarm_2.id
}

# Create Subnet in the Third AZ
resource "aws_subnet" "swarm_3" {
  vpc_id                  = aws_vpc.swarm.id
  cidr_block              = var.subnet_3_cidr
  availability_zone       = "eu-central-1c"
  map_public_ip_on_launch = true

  tags = {
    Owner       = var.owner
    Terraform   = true
    Environment = var.environment
    Name        = "swarm-subnet-3"
  }
}
# Create Routing table to grant permission outbound for subnet 3
resource "aws_route_table" "swarm_3" {
  vpc_id = aws_vpc.swarm.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.swarm.id
  }

  tags = {
    Owner       = var.owner
    Terraform   = true
    Environment = var.environment
    Name        = "swarm-route-table-swarm-3"
  }
}

# Associating routing table with subnet 3
resource "aws_route_table_association" "swarm_3" {
  subnet_id      = aws_subnet.swarm_3.id
  route_table_id = aws_route_table.swarm_3.id
}
