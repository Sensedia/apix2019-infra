#!/bin/bash

docker-compose up -d --no-deps --build rabbitmq mysql elasticsearch kibana logstash prometheus node-exporter alertmanager grafana blackbox cadvisor
