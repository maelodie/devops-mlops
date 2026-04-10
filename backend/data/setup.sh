#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

sudo docker rm -f tp1-db adminer 2>/dev/null || true
sudo docker network create app-network 2>/dev/null || true
sudo docker volume create tp1-db-data 2>/dev/null || true
sudo docker build -t tp1-postgres:1.0 .

sudo docker run -d \
  --name tp1-db \
  --network app-network \
  -p 5432:5432 \
  -e POSTGRES_DB=db \
  -e POSTGRES_USER=usr \
  -e POSTGRES_PASSWORD=pwd \
  -v tp1-db-data:/var/lib/postgresql/data \
  tp1-postgres:1.0

sudo docker logs --tail 50 tp1-db
sudo docker ps --filter name=tp1-db

sudo docker run -d \
  --name adminer \
  --network app-network \
  -p 8090:8080 \
  adminer

sudo docker ps --filter name=adminer