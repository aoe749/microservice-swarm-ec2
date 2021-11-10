# create SG for Docker SWARM VPC
resource "aws_security_group" "swarm_internet" {
  name        = "swarm_internet_access"
  description = "Security group for SWARM - Internet access"
  vpc_id      = aws_vpc.swarm.id

  #  Inbound from  Internet
  dynamic "ingress" {
    for_each = ["8500", "22", "4040", "15672", "8080", "8082", "8084", "4050", "80"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  # Outbound to Internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Owner       = var.owner
    Terraform   = true
    Environment = var.environment
    Name        = "swarm-sec-grp-inet-access"
  }
}

# Create SG for inter cluster communications
resource "aws_security_group" "swarm" {
  name        = "swarm_cluster_communications"
  description = "Security group for SWARM cluster communications"
  vpc_id      = aws_vpc.swarm.id

  dynamic "ingress" {
    for_each = ["5000", "8300", "8301", "8302", "8400", "8500", "53", "5672", "15672", "27017", "8080", "8082", "8084", "3306", "2377", "7946", "80"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  # LAN Gossip / Serf LAN
  ingress {
    from_port   = 8301
    to_port     = 8301
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # WAN Gossip / Serf WAN
  ingress {
    from_port   = 8302
    to_port     = 8302
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # DNS
  ingress {
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Control Plane gossip discovery
  ingress {
    from_port   = 7946
    to_port     = 7946
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Data Plane VXLAN overlay network traffic
  ingress {
    from_port   = 4789
    to_port     = 4789
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound to Internet
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Owner       = "${var.owner}"
    Terraform   = true
    Environment = "${var.environment}"
    Name        = "swarm-sec-grp-cluster-comm"
  }
}
