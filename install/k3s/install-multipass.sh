#!/bin/bash

set -e

show_help() {
  cat <<EOF
Usage: $0 [channel]

Install Multipass on Ubuntu/Debian.

Arguments:
  channel    Optional Multipass snap channel (default: stable)
EOF
  exit 1
}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  show_help
fi

CHANNEL=${1:-stable}

if command -v multipass >/dev/null 2>&1; then
  echo "✅ Multipass is already installed: $(multipass version 2>&1 | head -n 1)"
  exit 0
fi

if ! command -v snap >/dev/null 2>&1; then
  echo "⚠️  Snap is not available. Installing snapd..."
  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y snapd
  else
    echo "Error: apt-get is required to install snapd on this system." >&2
    exit 1
  fi
fi

echo "⚙️  Installing Multipass via snap ($CHANNEL)..."
sudo snap install multipass --classic --channel="$CHANNEL"

echo "✅ Multipass installed successfully."
