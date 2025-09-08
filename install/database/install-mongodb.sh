#!/usr/bin/env bash
set -e

echo "🚀 Installing MongoDB..."

read -p "Enter MongoDB version (default: latest): " MONGO_VERSION
MONGO_VERSION=${MONGO_VERSION:-latest}

read -p "Enter MongoDB root username (default: root): " MONGO_USER
MONGO_USER=${MONGO_USER:-root}

read -s -p "Enter MongoDB root password (default: example): " MONGO_PASS
MONGO_PASS=${MONGO_PASS:-example}
echo

docker volume create mongodb-data

docker run -d --name mongodb \
  -e MONGO_INITDB_ROOT_USERNAME=$MONGO_USER \
  -e MONGO_INITDB_ROOT_PASSWORD=$MONGO_PASS \
  -p 27017:27017 \
  -v mongodb-data:/data/db \
  mongo:$MONGO_VERSION

echo "✅ MongoDB running on port 27017 (user: $MONGO_USER / password: $MONGO_PASS)"