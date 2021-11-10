#!/bin/sh

# Deploys Swarm

set -e

# Setting values for script
# Swarm master's IPs
pr_key=~/.ssh/jenkins-Frankfurt.pem

export swarm_master=$(aws ec2 describe-instances \
  --filters Name='tag:Name,Values=Swarm-master' \
  --output text --query 'Reservations[*].Instances[*].PublicIpAddress')
echo "Swarm-master public ip: ${swarm_master}"

# export swarm_master_private_ip=$(aws ec2 describe-instances \
#   --filters Name='tag:Name,Values=Swarm-master' \
#   --output text --query 'Reservations[*].Instances[*].PrivateIpAddress')
# echo "Swarm-master private ip: ${swarm_master_private_ip}"

# Swarm manager's IPs
export swarm_manager_1=$(aws ec2 describe-instances \
  --filters Name='tag:Name,Values=Swarm-manager-1' \
  --output text --query 'Reservations[*].Instances[*].PublicIpAddress')
echo "Swarm-manager-1 public ip: ${swarm_manager_1}"

export swarm_manager_2=$(aws ec2 describe-instances \
  --filters Name='tag:Name,Values=Swarm-manager-2' \
  --output text --query 'Reservations[*].Instances[*].PublicIpAddress')
echo "Swarm-manager-2 public ip: ${swarm_manager_2}"

## Workers
export worker_1=$(aws ec2 describe-instances \
  --filters Name='tag:Name,Values=worker-1' \
  --output text --query 'Reservations[*].Instances[*].PublicIpAddress')
echo "Worker1 public ip: ${worker_1}"
export worker_2=$(aws ec2 describe-instances \
  --filters Name='tag:Name,Values=worker-2' \
  --output text --query 'Reservations[*].Instances[*].PublicIpAddress')
echo "Worker2 public ip: ${worker_2}"
export worker_3=$(aws ec2 describe-instances \
  --filters Name='tag:Name,Values=worker-3' \
  --output text --query 'Reservations[*].Instances[*].PublicIpAddress')
echo "Worker3 public ip: ${worker_3}"
# export worker_4=$(aws ec2 describe-instances \
#   --filters Name='tag:Name,Values=worker-4' \
#   --output text --query 'Reservations[*].Instances[*].PublicIpAddress')
# echo "Worker4 public ip: ${worker_4}"
# export worker_5=$(aws ec2 describe-instances \
#   --filters Name='tag:Name,Values=worker-5' \
#   --output text --query 'Reservations[*].Instances[*].PublicIpAddress')
# echo "Worker5 public ip: ${worker_5}"
# export worker_6=$(aws ec2 describe-instances \
#   --filters Name='tag:Name,Values=worker-6' \
#   --output text --query 'Reservations[*].Instances[*].PublicIpAddress')
# echo "Worker6 public ip: ${worker_6}"
# export worker_7=$(aws ec2 describe-instances \

#   --filters Name='tag:Name,Values=worker-7' \
#   --output text --query 'Reservations[*].Instances[*].PublicIpAddress')
# echo "Worker7 public ip: ${worker_7}"

############################################################
### Create SWARM, get join token and pass
############################################################
ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${swarm_master} docker swarm leave -f
ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${swarm_master} docker swarm init
ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${swarm_master} docker network create -d overlay --attachable swarm_net

join_mng=$(ssh -oStrictHostKeyChecking=no -T -i ~/.ssh/jenkins-Frankfurt.pem ec2-user@${swarm_master} docker swarm join-token manager | grep docker)
join_wrk=$(ssh -oStrictHostKeyChecking=no -T -i ~/.ssh/jenkins-Frankfurt.pem ec2-user@${swarm_master} docker swarm join-token worker | grep docker)

echo "${join_mng}"
echo "${join_wrk}"

# Connecting manager nodes to SWARM
echo "Connecting SWARM managers"
ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${swarm_manager_1} docker swarm leave -f
ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${swarm_manager_1} ${join_mng}

ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${swarm_manager_2} docker swarm leave -f
ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${swarm_manager_2} ${join_mng}

# Connecting workers nodes to SWARM

echo "Connecting SWARM Workers"
echo "Setting hostnames"
ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${worker_1} sudo hostnamectl set-hostname worker-1
ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${worker_2} sudo hostnamectl set-hostname worker-2
ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${worker_3} sudo hostnamectl set-hostname worker-3

ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${worker_1} docker swarm leave -f
ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${worker_1} ${join_wrk}

echo "1st ready"
#################

ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${worker_2} docker swarm leave -f
ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${worker_2} ${join_wrk}

echo "2nd ready"
#################

ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${worker_3} docker swarm leave -f
ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${worker_4} ${join_wrk}

echo "3rd ready"
echo "#################"

# ssh -oStrictHostKeyChecking=no -T \
#   -i ~/.ssh/jenkins-Frankfurt.pem ec2-user@${worker_4} << EOSSH
# sudo hostnamectl set-hostname worker-4
# docker swarm leave -f
# ${join_wrk}
# EOSSH
# echo "4th ready"
# echo "#################"
#
# ssh -oStrictHostKeyChecking=no -T \
#   -i ~/.ssh/jenkins-Frankfurt.pem ec2-user@${worker_5} << EOSSH
# sudo hostnamectl set-hostname worker-5
# docker swarm leave -f
# ${join_wrk}
# EOSSH
# echo "5th ready"
# echo "#################"
#
# ssh -oStrictHostKeyChecking=no -T \
#   -i ~/.ssh/jenkins-Frankfurt.pem ec2-user@${worker_6} << EOSSH
# sudo hostnamectl set-hostname worker-6
# docker swarm leave -f
# ${join_wrk}
# EOSSH
# echo "6th ready"
#
# echo "#################"

# ssh -oStrictHostKeyChecking=no -T \
#   -i ~/.ssh/jenkins-Frankfurt.pem ec2-user@${worker_7} << EOSSH
# sudo hostnamectl set-hostname worker-7,
# docker swarm leave -f
# ${join_wrk}
# EOSSH
# echo "7th ready"


#############################################################
### Fetching consul configs and send to SWARM
#############################################################
# aws s3 cp
#
scp -oStrictHostKeyChecking=no -T -i ${pr_key} consul/consul/config.json.s ec2-user@${swarm_master}:consul/config/config.json
scp -oStrictHostKeyChecking=no -T -i ${pr_key} compose/docker-full.yml ec2-user@${swarm_master}:/home/ec2-user
scp -oStrictHostKeyChecking=no -T -i ${pr_key} consul/config.json.s1 ec2-user@${swarm_manager_1}:consul/config/config.json
scp -oStrictHostKeyChecking=no -T -i ${pr_key} consul/config.json.s2 ec2-user@${swarm_manager_2}:consul/config/config.json

# scp -oStrictHostKeyChecking=no -T -i ~/.ssh/jenkins-Frankfurt.pem scripts/consul/config.json.a1 ec2-user@${worker_1}:consul/config/config.json
# scp -oStrictHostKeyChecking=no -T -i ~/.ssh/jenkins-Frankfurt.pem scripts/consul/config.json.a2 ec2-user@${worker_2}:consul/config/config.json
# scp -oStrictHostKeyChecking=no -T -i ~/.ssh/jenkins-Frankfurt.pem scripts/consul/config.json.a3 ec2-user@${worker_3}:consul/config/config.json
# scp -oStrictHostKeyChecking=no -T -i ~/.ssh/jenkins-Frankfurt.pem scripts/consul/config.json.a4 ec2-user@${worker_4}:consul/config/config.json
# scp -oStrictHostKeyChecking=no -T -i ~/.ssh/jenkins-Frankfurt.pem scripts/consul/config.json.a5 ec2-user@${worker_5}:consul/config/config.json
# scp -oStrictHostKeyChecking=no -T -i ~/.ssh/jenkins-Frankfurt.pem scripts/consul/config.json.a6 ec2-user@${worker_6}:consul/config/config.json./de
