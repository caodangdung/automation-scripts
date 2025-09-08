#!/usr/bin/env bash
set -e

echo "🚀 Installing SQL Server..."

read -p "Enter SQL Server version (default: 2022-latest): " SQL_VERSION
SQL_VERSION=${SQL_VERSION:-2022-latest}

read -s -p "Enter SA password (default: Password!123): " SA_PASS
SA_PASS=${SA_PASS:-Password!123}
echo

docker volume create sqlserver-data

docker run -d --name sqlserver \
  -e "ACCEPT_EULA=Y" \
  -e "SA_PASSWORD=$SA_PASS" \
  -p 1433:1433 \
  -v sqlserver-data:/var/opt/mssql \
  mcr.microsoft.com/mssql/server:$SQL_VERSION

echo "✅ SQL Server running on port 1433 (user: sa / password: $SA_PASS)"