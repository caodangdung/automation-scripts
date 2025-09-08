#!/usr/bin/env bash
set -e

echo "🚀 Installing Oracle XE..."

read -p "Enter Oracle XE version (default: latest): " ORACLE_VERSION
ORACLE_VERSION=${ORACLE_VERSION:-latest}

read -s -p "Enter Oracle SYS/SYSTEM password (default: Oracle123): " ORACLE_PASS
ORACLE_PASS=${ORACLE_PASS:-Oracle123}
echo

docker volume create oracle-data

docker run -d --name oracle \
  -p 1521:1521 -p 5500:5500 \
  -e ORACLE_PWD=$ORACLE_PASS \
  -v oracle-data:/opt/oracle/oradata \
  gvenzl/oracle-xe:$ORACLE_VERSION

echo "✅ Oracle XE running on port 1521 (user: system / password: $ORACLE_PASS)"