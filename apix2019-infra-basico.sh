#!/bin/bash

export COMPOSE_PROJECT_NAME=apix2019infra
docker-compose down
docker-compose -f docker-compose-trilha-basica.yml up -d --remove-orphans
docker-compose ps
