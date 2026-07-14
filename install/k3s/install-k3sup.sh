#!/bin/bash

set -e

show_help() {
  cat <<EOF
Usage: $0 [install-path]

Install k3sup to the local system.

Arguments:
  install-path   Optional destination path (default: /usr/local/bin/k3sup)
EOF
  exit 1
}

DEST=${1:-/usr/local/bin/k3sup}

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
  show_help
fi

ARCH=$(uname -m)
case "$ARCH" in
  x86_64|amd64) ARCH=amd64 ;;
  aarch64|arm64) ARCH=arm64 ;;
  *) echo "Error: unsupported architecture $ARCH" >&2; exit 1 ;;
esac

URL="https://github.com/alexellis/k3sup/releases/latest/download/k3sup-linux-$ARCH"

echo "⚙️  Installing k3sup to $DEST..."

tmpfile=$(mktemp)
trap 'rm -f "$tmpfile"' EXIT
curl -fsSL "$URL" -o "$tmpfile"
chmod +x "$tmpfile"
sudo install -m 0755 "$tmpfile" "$DEST"

if command -v k3sup >/dev/null 2>&1; then
  echo "✅ k3sup installed successfully: $(k3sup version 2>&1 | head -n 1)"
else
  echo "✅ k3sup installed to $DEST"
fi
