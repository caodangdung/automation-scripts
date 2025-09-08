#!/usr/bin/env bash
set -e

echo "🚀 Installing Cassandra..."

read -p "Enter Cassandra version (default: latest): " CASSANDRA_VERSION
CASSANDRA_VERSION=${CASSANDRA_VERSION:-latest}

# create volume if not exists
docker volume create cassandra-data >/dev/null

# run container
docker run -d --name cassandra \
  -p 9042:9042 \
  -v cassandra-data:/var/lib/cassandra \
  cassandra:$CASSANDRA_VERSION

echo "⏳ Waiting for Cassandra to start..."

# wait until Cassandra is ready (checks logs)
until docker logs cassandra 2>&1 | grep -q "Starting listening for CQL clients"; do
  sleep 5
done

echo "✅ Cassandra is running on port 9042"
echo "👉 You can connect with:"
echo "   docker exec -it cassandra cqlsh"