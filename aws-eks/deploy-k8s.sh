#!/bin/bash

clear
echo "Bem vindo ao assistente de instalação dos Modulos APIX2019"
echo ------------------------------------------------------------

echo "Informar os dados da sua conta AWS:"

echo 
echo "ID da conta"
read accountid


kubectl apply -f k8s/elastiseach-k8s/deployments.yaml
kubectl apply -f k8s/elastiseach-k8s/service.yaml

kubectl apply -f k8s/grafana-k8s/deployments.yaml
kubectl apply -f k8s/grafana-k8s/service.yaml

kubectl apply -f k8s/kibana-k8s/deployments.yaml
kubectl apply -f k8s/kibana-k8s/service.yaml

kubectl apply -f k8s/logstash-k8s/deployments.yaml
kubectl apply -f k8s/logstash-k8s/service.yaml

kubectl apply -f k8s/mysql-k8s/deployments.yaml
kubectl apply -f k8s/mysql-k8s/service.yaml

kubectl apply -f k8s/prometheus-k8s/deployments.yaml
kubectl apply -f k8s/prometheus-k8s/service.yaml

kubectl apply -f k8s/rabbitmq-k8s/deployments.yaml
kubectl apply -f k8s/rabbitmq-k8s/service.yaml


echo "Iniciando Deploy das apps ..."

aws ecr get-login --no-include-email --region us-west-2 | /bin/bash

aws ecr create-repository --repository-name apix2019-microservice-crawler-nodejs --region us-west-2
docker tag "sensedia/apix2019-microservice-crawler-nodejs":latest "${accountid}".dkr.ecr.us-west-2.amazonaws.com/"apix2019-microservice-crawler-nodejs":latest
docker push "${accountid}".dkr.ecr.us-west-2.amazonaws.com/apix2019-microservice-crawler-nodejs:latest

aws ecr create-repository --repository-name apix2019-microservice-finder-java --region us-west-2
docker tag "sensedia/apix2019-microservice-finder-java":latest "${accountid}".dkr.ecr.us-west-2.amazonaws.com/"apix2019-microservice-finder-java":latest
docker push "${accountid}".dkr.ecr.us-west-2.amazonaws.com/apix2019-microservice-finder-java:latest

aws ecr create-repository --repository-name apix2019-microservice-kit-java --region us-west-2
docker tag "sensedia/apix2019-microservice-kit-java":latest "${accountid}".dkr.ecr.us-west-2.amazonaws.com/"apix2019-microservice-kit-java":latest
docker push "${accountid}".dkr.ecr.us-west-2.amazonaws.com/apix2019-microservice-kit-java:latest

aws ecr create-repository --repository-name apix2019-microservice-notification-kotlin --region us-west-2
docker tag "sensedia/apix2019-microservice-notification-kotlin":latest "${accountid}".dkr.ecr.us-west-2.amazonaws.com/"apix2019-microservice-notification-kotlin":latest
docker push "${accountid}".dkr.ecr.us-west-2.amazonaws.com/apix2019-microservice-notification-kotlin:latest

aws ecr create-repository --repository-name apix2019-microservice-notification-nodejs --region us-west-2
docker tag "sensedia/apix2019-microservice-notification-nodejs":latest "${accountid}".dkr.ecr.us-west-2.amazonaws.com/"apix2019-microservice-notification-nodejs":latest
docker push "${accountid}".dkr.ecr.us-west-2.amazonaws.com/apix2019-microservice-notification-nodejs:latest


kubectl apply -f  apps/apix2019-microservice-crawler-nodejs/
kubectl apply -f  apps/apix2019-microservice-crawler-nodejs/deployments.yaml
kubectl apply -f  apps/apix2019-microservice-crawler-nodejs/service.yaml
kubectl apply -f  apps/apix2019-microservice-finder-java/
kubectl apply -f  apps/apix2019-microservice-finder-java/deployments.yaml
kubectl apply -f  apps/apix2019-microservice-finder-java/service.yaml
kubectl apply -f  apps/apix2019-microservice-kit-java/
kubectl apply -f  apps/apix2019-microservice-kit-java/deployments.yaml
kubectl apply -f  apps/apix2019-microservice-kit-java/service.yaml
kubectl apply -f  apps/apix2019-microservice-notification-kotlin/
kubectl apply -f  apps/apix2019-microservice-notification-kotlin/deployments.yaml
kubectl apply -f  apps/apix2019-microservice-notification-kotlin/service.yaml
kubectl apply -f  apps/apix2019-microservice-notification-nodejs/
kubectl apply -f  apps/apix2019-microservice-notification-nodejs/deployments.yaml
kubectl apply -f  apps/apix2019-microservice-notification-nodejs/service.yaml
