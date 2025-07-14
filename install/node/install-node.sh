#!/bin/bash

set -e

echo "✅ Installing Node.js (LTS)..."

curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "✅ Node version: $(node -v)"