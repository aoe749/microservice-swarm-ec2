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
#
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


ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${swarm_manager_1} docker swarm leave -f

ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${swarm_manager_2} docker swarm leave -f

ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${worker_1} docker swarm leave -f

ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${worker_2} docker swarm leave -f

ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${worker_3} docker swarm leave -f

ssh -oStrictHostKeyChecking=no -T -i ${pr_key} ec2-user@${swarm_master} docker swarm leave -f
