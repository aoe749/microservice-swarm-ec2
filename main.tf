provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "tf-state-remote-vm"
    key    = "terraform.swarm.tfstate"

  }
}
