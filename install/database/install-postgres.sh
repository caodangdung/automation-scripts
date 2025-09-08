#!/usr/bin/env bash
set -e

echo "🚀 Installing PostgreSQL..."

# --- inputs ---
printf "Enter PostgreSQL version (default: latest): "
read PG_VERSION ; PG_VERSION=${PG_VERSION:-latest}

printf "Enter PostgreSQL username (default: postgres): "
read PG_USER ; PG_USER=${PG_USER:-postgres}

printf "Enter PostgreSQL password (default: postgres): "
stty -echo; read PG_PASS; stty echo; echo
PG_PASS=${PG_PASS:-postgres}

printf "Bind address (default: *): "
read BIND_ADDR ; BIND_ADDR=${BIND_ADDR:-*}

printf "Allowed client IP/range (default: 0.0.0.0/0): "
read CLIENT_RANGE ; CLIENT_RANGE=${CLIENT_RANGE:-0.0.0.0/0}

printf "Do you want to create an extra user? (y/n, default n): "
read CREATE_USER ; CREATE_USER=${CREATE_USER:-n}
if [ "$CREATE_USER" = "y" ] || [ "$CREATE_USER" = "Y" ]; then
  printf "Enter new username: "
  read NEW_USER
  printf "Enter password for %s: " "$NEW_USER"
  stty -echo; read NEW_PASS; stty echo; echo
fi

# remove old container
docker rm -f postgres >/dev/null 2>&1 || true

# reset volume?
printf "Reset PostgreSQL data volume? (y/n, default n): "
read RESET_VOL ; RESET_VOL=${RESET_VOL:-n}
if [ "$RESET_VOL" = "y" ] || [ "$RESET_VOL" = "Y" ]; then
  docker volume rm postgres-data >/dev/null 2>&1 || true
fi

docker volume create postgres-data >/dev/null 2>&1 || true

docker run -d --name postgres \
  -e POSTGRES_USER="$PG_USER" \
  -e POSTGRES_PASSWORD="$PG_PASS" \
  -p 5432:5432 \
  -v postgres-data:/var/lib/postgresql/data \
  "postgres:$PG_VERSION" >/dev/null

echo "⏳ Waiting for PostgreSQL..."
sleep 15

# --- optional extra user ---
if [ "$CREATE_USER" = "y" ] || [ "$CREATE_USER" = "Y" ]; then
  docker exec -i postgres psql -U "$PG_USER" -d postgres -c \
    "DO \$\$ BEGIN IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = '$NEW_USER') THEN CREATE ROLE \"$NEW_USER\" LOGIN PASSWORD '$NEW_PASS'; END IF; END \$\$;"
  echo "👤 Extra user created: $NEW_USER"
fi

# configure listen_addresses + pg_hba
docker exec -i postgres bash <<EOS
CONF="\$PGDATA/postgresql.conf"
HBA="\$PGDATA/pg_hba.conf"

# wipe default HBA
# echo "" > "\$HBA"

# set listen
if grep -q "^[# ]*listen_addresses" "\$CONF"; then
  sed -i "s/^[# ]*listen_addresses.*/listen_addresses = '$BIND_ADDR'/g" "\$CONF"
else
  echo "listen_addresses = '$BIND_ADDR'" >> "\$CONF"
fi

# add only what we want
echo "host all all $CLIENT_RANGE scram-sha-256" >> "\$HBA"
EOS

docker restart postgres >/dev/null

HOST_IP=$(hostname -I 2>/dev/null | awk '{print $1}')
echo "✅ PostgreSQL running!"
echo "   Host: ${HOST_IP:-<your-host-ip>}"
echo "   Port: 5432"
echo "   User: $PG_USER"
echo "   Pass: $PG_PASS"
echo "   Bind: $BIND_ADDR"
echo "   Allowed: $CLIENT_RANGE"