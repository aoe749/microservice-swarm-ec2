# Instance-1 for ConsulLeader and Swarm Master
resource "aws_instance" "master" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = "jenkins-Frankfurt"
  vpc_security_group_ids = ["${aws_security_group.swarm.id}", "${aws_security_group.swarm_internet.id}"]
  subnet_id              = aws_subnet.swarm_1.id
  user_data              = file("master.sh")

  connection {
    user        = "ec2-user"
    private_key = file("$HOME/.ssh/jenkins-Frankfurt.pem")
    timeout     = var.connection_timeout
    host        = aws_instance.master.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname master",
      "mkdir -p consul/data",
      "mkdir -p consul/config"
    ]
  }

  tags = {
    Owner       = var.owner
    Terraform   = true
    Environment = var.environment
    Name        = "Swarm-master"
  }

}
# Instance-2 for App2 and Swarm manager 2
resource "aws_instance" "manager1" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = "jenkins-Frankfurt"
  vpc_security_group_ids = ["${aws_security_group.swarm.id}", "${aws_security_group.swarm_internet.id}"]
  subnet_id              = aws_subnet.swarm_2.id
  user_data              = file("startup_amz.sh")

  connection {
    user        = "ec2-user"
    private_key = file("$HOME/.ssh/jenkins-Frankfurt.pem")
    timeout     = var.connection_timeout
    host        = aws_instance.manager1.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname manager-1",
      "mkdir -p consul/data",
      "mkdir -p consul/config"
    ]
  }


  tags = {
    Owner       = var.owner
    Terraform   = true
    Environment = var.environment
    Name        = "Swarm-manager-1"

  }
}

# Instance-3 for Swarm manager 3
resource "aws_instance" "manager2" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = "jenkins-Frankfurt"
  vpc_security_group_ids = ["${aws_security_group.swarm.id}", "${aws_security_group.swarm_internet.id}"]
  subnet_id              = aws_subnet.swarm_3.id
  user_data              = file("startup_amz.sh")

  connection {
    user        = "ec2-user"
    private_key = file("$HOME/.ssh/jenkins-Frankfurt.pem")
    timeout     = var.connection_timeout
    host        = aws_instance.manager2.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname manager-2",
      "mkdir -p consul/data",
      "mkdir -p consul/config"
    ]
  }


  tags = {
    Owner       = var.owner
    Terraform   = true
    Environment = var.environment
    Name        = "Swarm-manager-2"

  }
}


resource "aws_instance" "worker" {
  ami                    = data.aws_ami.latest_amazon_linux.id
  instance_type          = "t2.micro"
  key_name               = "jenkins-Frankfurt"
  vpc_security_group_ids = ["${aws_security_group.swarm.id}", "${aws_security_group.swarm_internet.id}"]
  subnet_id              = aws_subnet.swarm_1.id
  user_data              = file("worker.sh")
  count                  = 3



  connection {
    user        = "ec2-user"
    private_key = file("$HOME/.ssh/jenkins-Frankfurt.pem")
    timeout     = var.connection_timeout
    host        = self.public_ip

  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p consul/data",
      "mkdir -p consul/config"
    ]
  }


  tags = {
    Owner       = var.owner
    Terraform   = true
    Environment = var.environment
    Name        = "${format("worker-%d", count.index + 1)}"

  }
}

# locals {
#   worker = tolist([
#     for server in aws_instance.worker :
#     server.private_ip
#   ])
# }
