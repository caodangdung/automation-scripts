#!/usr/bin/env bash
set -e

echo "🚀 Installing CloudBeaver..."

read -p "Enter CloudBeaver version (default: latest): " CB_VERSION
CB_VERSION=${CB_VERSION:-latest}

docker volume create cloudbeaver-data

docker run -d --name cloudbeaver \
  -p 8978:8978 \
  -v cloudbeaver-data:/opt/cloudbeaver/workspace \
  dbeaver/cloudbeaver:$CB_VERSION

echo "✅ CloudBeaver running on http://localhost:8978"