#!/usr/bin/env bash
set -e

echo "🚀 Installing MySQL..."

read -p "Enter MySQL version (default: latest): " MYSQL_VERSION
MYSQL_VERSION=${MYSQL_VERSION:-latest}

printf "Enter MySQL root password (default: root): "
stty -echo
read MYSQL_PASS
stty echo
echo
MYSQL_PASS=${MYSQL_PASS:-root}

# Ask about creating a new user
read -p "Do you want to create an extra user? (y/n, default n): " CREATE_USER
CREATE_USER=${CREATE_USER:-n}
if [ "$CREATE_USER" = "y" ] || [ "$CREATE_USER" = "Y" ]; then
  read -p "Enter new username: " NEW_USER
  printf "Enter password for $NEW_USER: "
  stty -echo
  read NEW_PASS
  stty echo
  echo
fi

# Remove old container if exists
docker rm -f mysql >/dev/null 2>&1 || true

# Optionally reset volume
read -p "Reset MySQL data volume? (y/n, default n): " RESET_VOL
RESET_VOL=${RESET_VOL:-n}
if [ "$RESET_VOL" = "y" ] || [ "$RESET_VOL" = "Y" ]; then
  docker volume rm mysql-data >/dev/null 2>&1 || true
fi

# Create volume
docker volume create mysql-data >/dev/null 2>&1 || true

# Detect version for auth plugin
AUTH_PLUGIN=""
if echo "$MYSQL_VERSION" | grep -q "^8"; then
  AUTH_PLUGIN="--default-authentication-plugin=mysql_native_password"
fi

# Run MySQL
docker run -d --name mysql \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_PASS \
  -p 3306:3306 \
  -v mysql-data:/var/lib/mysql \
  mysql:$MYSQL_VERSION \
  $AUTH_PLUGIN \
  --bind-address=0.0.0.0

echo "⏳ Waiting for MySQL to initialize..."
sleep 20

# Create extra user if requested
if [ "$CREATE_USER" = "y" ] || [ "$CREATE_USER" = "Y" ]; then
  docker exec -i mysql mysql -uroot -p$MYSQL_PASS -e \
    "CREATE USER IF NOT EXISTS '$NEW_USER'@'%' IDENTIFIED BY '$NEW_PASS';
     GRANT ALL PRIVILEGES ON *.* TO '$NEW_USER'@'%' WITH GRANT OPTION;
     FLUSH PRIVILEGES;"
  echo "👤 Extra user created: $NEW_USER / $NEW_PASS"
fi

echo "✅ MySQL is running!"
echo "   Host: $(hostname -I | awk '{print $1}')"
echo "   Port: 3306"
echo "   Root User: root"
echo "   Root Pass: $MYSQL_PASS"