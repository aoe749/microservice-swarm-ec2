# Create a VPC to launch our instances into
resource "aws_vpc" "swarm" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Owner       = "${var.owner}"
    Terraform   = true
    Environment = "${var.environment}"
    Name        = "swarm-vpc"
  }
}

# resource "aws_vpc_dhcp_options" "swarm" {
#   domain_name         = "swarm.local"
#   domain_name_servers = ["AmazonProvidedDNS"]
#
#   tags = {
#     Name = "DHCP"
#   }
# }
#
# resource "aws_vpc_dhcp_options_association" "swarm_resolver" {
#   vpc_id          = aws_vpc.swarm.id
#   dhcp_options_id = aws_vpc_dhcp_options.swarm.id
# }
