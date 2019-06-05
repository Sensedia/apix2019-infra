#!/bin/bash

clear
echo "Bem vindo ao assistente de instalação dos Modulos APIX2019"
echo ------------------------------------------------------------

echo "Informar os dados da sua conta AWS:"

echo 
echo "ID da conta"
read accountid

#Instalaçã de dependencias

curl -o aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.12.7/2019-03-27/bin/linux/amd64/aws-iam-authenticator
sleep 3
chmod +x aws-iam-authenticator
sudo mv aws-iam-authenticator /usr/bin

sudo apt-get install awscli

#Inicializando terraform

cd cluster
terraform init
terraform plan

terraform apply --auto-approve

echo "Iniciando Deploy dos serviços ..."

#deploy apps service no k8s
for i in T=$(ls k8s/); do
        
	APP=$(echo $i | sed -e 's/T=//g')

	echo ---------------------------------------
	echo APP: $APP

#	kubectl apply -f k8s/${APP}/deployments.yaml
#	kubectl apply -f k8s/${APP}/service.yaml
done

echo "Iniciando Deploy das apps ..."
#deploy apps service no k8s
for i in T=$(ls apps/); do

        APP=$(echo $i | sed -e 's/T=//g')

        echo ---------------------------------------
        echo APP: $APP

        #login no ecr
        $(aws ecr get-login --no-include-email --region us-east-1)

        aws ecr create-repository --repository-name ${APP} --region us-west-2
        docker tag "${APP}":latest "${accountid}".dkr.ecr.us-west-2.amazonaws.com/"${APP}":latest
        #docker push "${accountid}".dkr.ecr.us-west-2.amazonaws.com/"${APP}":latest


#       kubectl apply -f apps/${APP}/deployments.yaml
#       kubectl apply -f apps/${APP}/service.yaml
done

