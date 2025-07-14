#!/bin/bash

set -e

echo "✅ Installing Docker Compose..."

sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose

echo "✅ Installed version: $(docker-compose --version)"