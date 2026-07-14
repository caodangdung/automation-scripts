#!/bin/bash

set -e

show_help() {
  cat <<EOF
Usage: $0 [key-path] [email] [--force]

Generate an SSH key pair.

Arguments:
  key-path   Optional path for the private key (default: ~/.ssh/id_rsa)
  email      Optional email/comment to attach to the public key (default: user@host)
  --force    Overwrite the key if it already exists
EOF
  exit 1
}

KEY_PATH="$HOME/.ssh/id_rsa"
COMMENT="$(whoami)@$(hostname)"
FORCE=0

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -h|--help)
      show_help
      ;;
    --force)
      FORCE=1
      shift
      ;;
    *)
      if [[ -z "$KEY_PATH_ARG" ]]; then
        KEY_PATH_ARG="$1"
      elif [[ -z "$COMMENT_ARG" ]]; then
        COMMENT_ARG="$1"
      else
        echo "Unknown option: $1"
        show_help
      fi
      shift
      ;;
  esac
done

if [[ -n "$KEY_PATH_ARG" ]]; then
  KEY_PATH="$KEY_PATH_ARG"
fi
if [[ -n "$COMMENT_ARG" ]]; then
  COMMENT="$COMMENT_ARG"
fi

mkdir -p "$(dirname "$KEY_PATH")"
chmod 700 "$(dirname "$KEY_PATH")"

if [[ -e "$KEY_PATH" && "$FORCE" -ne 1 ]]; then
  echo "SSH key already exists at $KEY_PATH"
  echo "Use --force to overwrite."
  exit 0
fi

if [[ "$FORCE" -eq 1 && -e "$KEY_PATH" ]]; then
  rm -f "$KEY_PATH" "$KEY_PATH.pub"
fi

ssh-keygen -t rsa -b 4096 -C "$COMMENT" -f "$KEY_PATH" -N ""
chmod 600 "$KEY_PATH"
chmod 644 "$KEY_PATH.pub"

echo "✅ SSH key pair generated:"
echo "  Private: $KEY_PATH"
echo "  Public:  $KEY_PATH.pub"
