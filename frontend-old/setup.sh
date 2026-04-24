#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

sudo docker rm -f frontend 2>/dev/null || true
sudo docker network create app-network 2>/dev/null || true
sudo docker build -t tp1-frontend:1.0 .

sudo docker run -d \
  --name frontend \
  --network app-network \
  -p 8091:80 \
  tp1-frontend:1.0