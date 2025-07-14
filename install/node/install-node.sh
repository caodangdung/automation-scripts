#!/bin/bash

# Usage:
#   ./install-node.sh             => installs latest LTS Node.js
#   ./install-node.sh 18.20.2     => installs specific version

set -e

# Function to install latest LTS version
install_latest_lts() {
  echo "⚙️  Installing latest LTS version of Node.js..."
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  sudo apt-get install -y nodejs
  echo "✅ Installed Node.js version: $(node -v)"
}

# Function to install specific version (major version only supported by NodeSource)
install_specific_version() {
  VERSION="$1"
  MAJOR_VERSION=$(echo "$VERSION" | cut -d. -f1)

  echo "⚙️  Installing Node.js version $VERSION..."

  # Add NodeSource repo for the major version
  curl -fsSL https://deb.nodesource.com/setup_${MAJOR_VERSION}.x | sudo -E bash -
  sudo apt-get install -y nodejs

  INSTALLED_VERSION=$(node -v | sed 's/v//')

  if [ "$INSTALLED_VERSION" = "$VERSION" ]; then
    echo "✅ Node.js $VERSION installed successfully."
  else
    echo "⚠️  Installed version is $INSTALLED_VERSION — may not match exact $VERSION."
    echo "   NodeSource only provides latest patch for each major version."
  fi
}

# Main logic
if [ -z "$1" ]; then
  install_latest_lts
else
  install_specific_version "$1"
fi