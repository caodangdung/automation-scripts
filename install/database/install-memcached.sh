#!/usr/bin/env bash
set -e

echo "🚀 Installing Memcached..."

read -p "Enter Memcached version (default: latest): " MEMCACHED_VERSION
MEMCACHED_VERSION=${MEMCACHED_VERSION:-latest}

docker run -d --name memcached \
  -p 11211:11211 \
  memcached:$MEMCACHED_VERSION

echo "✅ Memcached running on port 11211"