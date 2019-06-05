#!/bin/bash

clear

#Instalaçã de dependencias

curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.12.7/2019-03-27/bin/linux/amd64/aws-iam-authenticator
sleep 3
chmod +x aws-iam-authenticator
sudo mv aws-iam-authenticator /usr/bin

sudo rm -f /usr/bin/terraform
sudo snap install terraform
sudo pip3 install awscli

#Inicializando terraform

cd cluster
/snap/bin/terraform init
/snap/bin/terraform plan

/snap/bin/terraform apply --auto-approve