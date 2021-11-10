#!/bin/bash

# Set the servers PrivateIpAddresses
# Consul
#export consul_host=$(aws ec2 describe-instances \
#  --filters Name='tag:Name,Values=epam-consul-server-1' \
#  --output text --query 'Reservations[*].Instances[*].PrivateIpAddress')
#echo "Consul-Server-1 private ip: ${consul_host}"
#
# MongoDB
#export mongodb_host=$(aws ec2 describe-instances \
#  --filters Name='tag:Name,Values=epam-mongodb-server' \
#  --output text --query 'Reservations[*].Instances[*].PrivateIpAddress')
#echo "MongoDB-Server private ip: ${mongodb_host}"

# RabbitMQ
#export rabbitmq_host=$(aws ec2 describe-instances \
#  --filters Name='tag:Name,Values=epam-rabbitmq-server' \
#  --output text --query 'Reservations[*].Instances[*].PrivateIpAddress')
#echo "RabbitMQ-Server-1 private ip: ${rabbitmq_host}"

# APP1
#export app1_host=$(aws ec2 describe-instances \
#  --filters Name='tag:Name,Values=epam-app1-server' \
#  --output text --query 'Reservations[*].Instances[*].PrivateIpAddress')
#echo "App1-Server private ip: ${app1_host}"

sed -i -e "s~<CONSUL_HOST>~consul~g"service-one/src/main/resources/application.yml
sed -i -e "s~data.mongodb.uri:~data:service-one-db~g" service-one/src/main/resources/application.yml
sed -i -e "s~<HOSTNAME>~$HOST_NAME~g"service-one/src/main/resources/application.yml
sed -i -e "s~<MONGODB_HOST>~service-one-db~g" service-one/src/main/resources/application.yml
sed -i -e "s~<RABBITMQ_HOST>~rabbitmq~g" service-one/src/main/resources/application.yml
sed -i -e "s~<RABBITMQ_USER>~epam_rabbit~g" service-one/src/main/resources/application.yml
sed -i -e "s~<RABBITMQ_PASSWORD>~epam_rabbit~g" service-one/src/main/resources/application.yml
