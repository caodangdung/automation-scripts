#!/bin/bash
# Auto install and configure NFS Server with dynamic config
# Works on Ubuntu/Debian

# ===== DEFAULT CONFIG =====
DEFAULT_NFS_DIR="/srv/nfs_share"
DEFAULT_NFS_CLIENT_IP="*"
DEFAULT_NFS_OPTIONS="rw,sync,no_subtree_check,no_root_squash"

# ===== USER INPUTS =====
read -p "Enter NFS shared directory [${DEFAULT_NFS_DIR}]: " NFS_DIR
NFS_DIR=${NFS_DIR:-$DEFAULT_NFS_DIR}

read -p "Enter allowed client IP/CIDR [${DEFAULT_NFS_CLIENT_IP}]: " NFS_CLIENT_IP
NFS_CLIENT_IP=${NFS_CLIENT_IP:-$DEFAULT_NFS_CLIENT_IP}

read -p "Enter NFS export options [${DEFAULT_NFS_OPTIONS}]: " NFS_OPTIONS
NFS_OPTIONS=${NFS_OPTIONS:-$DEFAULT_NFS_OPTIONS}

echo "==== Installing NFS Server ===="
sudo apt update -y
sudo apt install -y nfs-kernel-server

echo "==== Creating NFS share directory ===="
sudo mkdir -p "$NFS_DIR"
sudo chown nobody:nogroup "$NFS_DIR"
sudo chmod 777 "$NFS_DIR"

echo "==== Configuring /etc/exports ===="
EXPORT_LINE="$NFS_DIR $NFS_CLIENT_IP($NFS_OPTIONS)"
if ! grep -q "$NFS_DIR" /etc/exports; then
    echo "$EXPORT_LINE" | sudo tee -a /etc/exports
else
    echo "Entry for $NFS_DIR already exists in /etc/exports"
fi

echo "==== Restarting NFS server ===="
sudo exportfs -ra
sudo systemctl enable --now nfs-kernel-server

SERVER_IP=$(hostname -I | awk '{print $1}')
echo "==== NFS Server setup complete ===="
echo "Server IP: $SERVER_IP"
echo "Shared Dir: $NFS_DIR"
echo "Allowed Clients: $NFS_CLIENT_IP"
echo "Options: $NFS_OPTIONS"