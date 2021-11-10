#!/bin/bash

#export appversion=2.0.2.0.2
# Set the servers PrivateIpAddresses
#export HOST_NAME=$app2-server
# Consul
#export consul_host=$(aws ec2 describe-instances \
#  --filters Name='tag:Name,Values=epam-consul-server-1' \
#  --output text --query 'Reservations[*].Instances[*].PrivateIpAddress')
#echo "Consul-Server-1 private ip: ${consul_host}"
#
# Mysql
#export mysql_host=$(aws ec2 describe-instances \
#  --filters Name='tag:Name,Values=epam-mysql-server' \
#  --output text --query 'Reservations[*].Instances[*].PrivateIpAddress')
#echo "MySQL Server private ip: ${mysql_host}"
#
# RabbitMQ
#export rabbitmq_host=$(aws ec2 describe-instances \
#  --filters Name='tag:Name,Values=epam-rabbitmq-server' \
#  --output text --query 'Reservations[*].Instances[*].PrivateIpAddress')
#echo "RabbitMQ-Server-1 private ip: ${rabbitmq_host}"

# APP2
#export app2_host=$(aws ec2 describe-instances \
#  --filters Name='tag:Name,Values=epam-app2-server' \
#  --output text --query 'Reservations[*].Instances[*].PrivateIpAddress')
#echo "App2 Server private ip: ${app2_host}"

# Logstash
#export logstash_host=$(aws ec2 describe-instances \
#  --filters Name='tag:Name,Values=epam-logstash-server' \
#  --output text --query 'Reservations[*].Instances[*].PrivateIpAddress')
#echo "App2 Server private ip: ${logstash_host}"

sed -i -e "s~<consul FQDN/IP>~consul~g" service-two/src/main/resources/application.yml
sed -i -e "s~<application host FQDN/IP>~service-two~g" service-two/src/main/resources/application.yml
sed -i -e "s~<MySQL DB FQDN/IP>~service-two-db~g" service-two/src/main/resources/application.yml
sed -i -e "s~<DB name>~service-two~g" service-two/src/main/resources/application.yml
sed -i -e "s~<DB username>~service-two~g" service-two/src/main/resources/application.yml
sed -i -e "s~<DB password>~service-two~g" service-two/src/main/resources/application.yml
sed -i -e "s~<RabbitMQ FQDN/IP>~rabbitmq~g" service-two/src/main/resources/application.yml
sed -i -e "s~<RabbitMQ username>~epam_rabbit~g" service-two/src/main/resources/application.yml
sed -i -e "s~<RabbitMQ password>~epam_rabbit~g" service-two/src/main/resources/application.yml
sed -i -e "s~<app version>~${appversion}~g" service-two/src/main/resources/application.yml
sed -i -e "s~logstash:~#logstash~g" service-two/src/main/resources/application.yml
sed -i -e "s~servers: <Logstash FQDN/IP>:5000~#servers: <Logstash FQDN/IP>:5000~g" service-two/src/main/resources/application.yml
