#!/bin/bash

set -e

echo "✅ Hardening SSH config..."

sudo sed -i 's/^#PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

sudo systemctl reload sshd

echo "✅ SSH hardening applied."