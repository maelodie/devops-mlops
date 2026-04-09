#!/bin/bash

sudo docker rm -f frontend 2>/dev/null || true

sudo docker build -t tp1-frontend:1.0 .

sudo docker run -d \
  --name frontend \
  --network app-network \
  -p 8091:80 \
  tp1-frontend:1.0