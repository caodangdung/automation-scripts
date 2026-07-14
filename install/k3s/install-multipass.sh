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

if command -v snap >/dev/null 2>&1; then
  echo "⚙️  Installing Multipass via snap ($CHANNEL)..."
  sudo snap install multipass --classic --channel="$CHANNEL"
else
  echo "⚠️  Snap is not available. Falling back to Multipass install script..."
  curl -fsSL https://multipass.run/install.sh | sudo bash
fi

echo "✅ Multipass installed successfully."
