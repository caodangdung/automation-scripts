#!/bin/bash

# Usage:
#   ./install-node-nvm.sh             => installs latest LTS Node.js via nvm
#   ./install-node-nvm.sh 18.20.2     => installs specific version via nvm

set -e

NVM_DIR="$HOME/.nvm"

# Install nvm if not already installed
install_nvm() {
  if [ ! -d "$NVM_DIR" ]; then
    echo "📥 Installing latest version of nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash
  else
    echo "✅ nvm already installed."
  fi

  # Load nvm immediately
  export NVM_DIR="$HOME/.nvm"
  # shellcheck disable=SC1090
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# Install latest LTS Node.js
install_latest_lts() {
  echo "⚙️ Installing latest LTS version of Node.js using nvm..."
  nvm install --lts
  nvm use --lts
  nvm alias default lts/*
  echo "✅ Installed Node.js version: $(node -v)"
}

# Install specific Node.js version
install_specific_version() {
  VERSION="$1"
  echo "⚙️ Installing Node.js version $VERSION using nvm..."
  nvm install "$VERSION"
  nvm use "$VERSION"
  nvm alias default "$VERSION"
  echo "✅ Installed Node.js version: $(node -v)"
}

# === Main Script ===
install_nvm

if [ -z "$1" ]; then
  install_latest_lts
else
  install_specific_version "$1"
fi