variable "aws_region" {
  description = "Default AWS Region for the VPC"
  default     = "eu-central-1"
}

variable "public_key_path" {
  default = "ssl/jenkins-Frankfurt.pub"
}

variable "aws_key_name" {
  default = "jenkins-Frankfurt"
}

variable "connection_timeout" {
  default = "120s"
}

variable "vpc_cidr" {
  description = "CIDR for the whole VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_1_cidr" {
  description = "CIDR for the Subnet 1"
  default     = "10.0.1.0/24"
}

variable "subnet_2_cidr" {
  description = "CIDR for the Subnet 2"
  default     = "10.0.2.0/24"
}

variable "subnet_3_cidr" {
  description = "CIDR for the Subnet 3"
  default     = "10.0.3.0/24"
}

variable "owner" {
  description = "Infrastructure Owner"
  default     = "Viktor Muradyan"
}

variable "environment" {
  description = "Infrastructure Environment"
  default     = "Docker SWARM Practice "
}

variable "cnt" {
  description = "Count Index"
  default     = "3"
}
