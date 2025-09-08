#!/usr/bin/env bash
set -e

echo "🚀 Installing Redis..."

read -p "Enter Redis version (default: latest): " REDIS_VERSION
REDIS_VERSION=${REDIS_VERSION:-latest}

docker volume create redis-data

docker run -d --name redis \
  -p 6379:6379 \
  -v redis-data:/data \
  redis:$REDIS_VERSION \
  redis-server --appendonly yes

echo "✅ Redis running on port 6379"