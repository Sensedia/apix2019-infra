#!/bin/bash

export COMPOSE_PROJECT_NAME=apix2019infra
docker-compose down
docker-compose up --build -d
docker-compose ps
