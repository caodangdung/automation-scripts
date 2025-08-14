#!/bin/bash
# Auto install and configure NFS Client (dynamic, container/VM compatible)

# ===== DEFAULT CONFIG =====
DEFAULT_SERVER_IP="192.168.1.100"
DEFAULT_NFS_DIR="/srv/nfs_share"
DEFAULT_MOUNT_POINT="/mnt/nfs_share"

# ===== INPUT HANDLING =====
if [ -t 0 ]; then
    read -p "Enter NFS Server IP [${DEFAULT_SERVER_IP}]: " SERVER_IP
    SERVER_IP=${SERVER_IP:-$DEFAULT_SERVER_IP}

    read -p "Enter NFS shared directory path on server [${DEFAULT_NFS_DIR}]: " NFS_DIR
    NFS_DIR=${NFS_DIR:-$DEFAULT_NFS_DIR}

    read -p "Enter local mount point [${DEFAULT_MOUNT_POINT}]: " MOUNT_POINT
    MOUNT_POINT=${MOUNT_POINT:-$DEFAULT_MOUNT_POINT}
else
    echo "Non-interactive mode detected — using defaults unless env vars are set"
    SERVER_IP="${SERVER_IP:-$DEFAULT_SERVER_IP}"
    NFS_DIR="${NFS_DIR:-$DEFAULT_NFS_DIR}"
    MOUNT_POINT="${MOUNT_POINT:-$DEFAULT_MOUNT_POINT}"
fi

echo "==== Installing NFS Client ===="
sudo apt update -y
sudo apt install -y nfs-common

echo "==== Creating local mount point ===="
sudo mkdir -p "$MOUNT_POINT"

echo "==== Mounting NFS share ===="
sudo mount "$SERVER_IP:$NFS_DIR" "$MOUNT_POINT"

# Add to /etc/fstab for auto-mount
if ! grep -q "$MOUNT_POINT" /etc/fstab; then
    echo "$SERVER_IP:$NFS_DIR $MOUNT_POINT nfs defaults 0 0" | sudo tee -a /etc/fstab
fi

echo "==== NFS Client setup complete ===="
echo "Mounted $SERVER_IP:$NFS_DIR to $MOUNT_POINT"
