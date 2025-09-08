#!/usr/bin/env bash
set -e

echo "🚀 Installing MariaDB..."

read -p "Enter MariaDB version (default: latest): " DB_VERSION
DB_VERSION=${DB_VERSION:-latest}

read -p "Enter MariaDB root username (default: root): " DB_USER
DB_USER=${DB_USER:-root}

read -s -p "Enter MariaDB root password (default: root): " DB_PASS
DB_PASS=${DB_PASS:-root}
echo

docker volume create mariadb-data

docker run -d --name mariadb \
  -e MYSQL_ROOT_USER=$DB_USER \
  -e MYSQL_ROOT_PASSWORD=$DB_PASS \
  -p 3306:3306 \
  -v mariadb-data:/var/lib/mysql \
  mariadb:$DB_VERSION

echo "✅ MariaDB running on port 3306 (user: $DB_USER / password: $DB_PASS)"