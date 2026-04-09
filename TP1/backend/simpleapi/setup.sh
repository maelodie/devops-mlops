#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

sudo docker rm -f backend 2>/dev/null || true
sudo docker network create app-network 2>/dev/null || true
sudo docker build -t tp1-backend:1.0 .

sudo docker run -d \
  --name backend \
  --network app-network \
  -e SPRING_DATASOURCE_URL=jdbc:postgresql://tp1-db:5432/db \
  -e SPRING_DATASOURCE_USERNAME=usr \
  -e SPRING_DATASOURCE_PASSWORD=pwd \
  -p 8080:8080 \
  tp1-backend:1.0