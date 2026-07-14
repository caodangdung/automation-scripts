#!/bin/bash

show_help() {
  cat <<EOF
Usage: $0 --control-plane-nodes <nodes> --worker-nodes <count> --name <name>
          [--control-plane-cpus <cpus>] [--control-plane-memory <memory>]
          [--worker-cpus <cpus>] [--worker-memory <memory>]
          [--ssh-public-key <path>] [--ssh-private-key <path>]
          [--control-plane-disk <disk>] [--worker-disk <disk>]
          [-h|--help]

Required arguments:
  --control-plane-nodes <count>     List of control plane nodes
  --worker-nodes <count>            Number of worker nodes
  --name <name>                     Name for the deployment

Optional:
  --control-plane-cpus <cpus>       CPUs for control plane nodes (integer) (default: 1)
  --control-plane-memory <memory>   Memory for control plane nodes (e.g., 2G, 512M) (default: 1G)
  --control-plane-disk <disk>       Disk space to allocate (e.g., 2G, 512M) (default: 5G)
  --worker-cpus <cpus>              CPUs for worker nodes (integer) (default: 1)
  --worker-memory <memory>          Memory for worker nodes (e.g., 2G, 512M) (default: 1G)
  --worker-disk <disk>              Disk space to allocate (e.g., 2G, 512M) (default: 5G)
  --ssh-public-key <path>           Path to SSH public key (default: ~/.ssh/id_rsa.pub)
  --ssh-private-key <path>          Path to SSH private key (default: ~/.ssh/id_rsa)
  -h, --help                        Show this help message and exit
EOF
  exit 1
}

# Initialize variables
SSH_PUBLIC_KEY_PATH="$HOME/.ssh/id_rsa.pub"
SSH_PRIVATE_KEY_PATH="$HOME/.ssh/id_rsa"
USER="ubuntu"
CONTROL_PLANE_CPUS="1"
CONTROL_PLANE_MEMORY="1G"
CONTROL_PLANE_DISK="5G"
WORKER_CPUS="1"
WORKER_MEMORY="1G"
WORKER_DISK="5G"
CONTROL_PLANE_NODES=""
WORKER_NODES=""
NAME=""

# Parse args
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --control-plane-nodes) CONTROL_PLANE_NODES="$2"; shift 2 ;;
    --worker-nodes) WORKER_NODES="$2"; shift 2 ;;
    --name) NAME="$2"; shift 2 ;;
    --ssh-public-key) SSH_PUBLIC_KEY_PATH="$2"; shift 2 ;;
    --ssh-private-key) SSH_PRIVATE_KEY_PATH="$2"; shift 2 ;;
    --control-plane-cpus) CONTROL_PLANE_CPUS="$2"; shift 2 ;;
    --control-plane-memory) CONTROL_PLANE_MEMORY="$2"; shift 2 ;;
    --control-plane-disk) CONTROL_PLANE_DISK="$2"; shift 2 ;;
    --worker-cpus) WORKER_CPUS="$2"; shift 2 ;;
    --worker-memory) WORKER_MEMORY="$2"; shift 2 ;;
    --worker-disk) WORKER_DISK="$2"; shift 2 ;;
    -h|--help) show_help ;;
    *) echo "Unknown option: $1"; show_help ;;
  esac
done


if [[ -z "$CONTROL_PLANE_NODES" || -z "$WORKER_NODES" || -z "$NAME" ]]; then
    echo "Error: --control-plane-nodes, --worker-nodes, and --name are required."
    show_help
fi

# Validate integers
if ! [[ "$WORKER_NODES" =~ ^[0-9]+$ ]]; then
  echo "Error: --worker-nodes must be an integer."; exit 1
fi
if ! [[ "$CONTROL_PLANE_CPUS" =~ ^[0-9]+$ ]]; then
  echo "Error: --control-plane-cpus must be an integer."; exit 1
fi
if ! [[ "$WORKER_CPUS" =~ ^[0-9]+$ ]]; then
  echo "Error: --worker-cpus must be an integer."; exit 1
fi

# Validate memory strings
MEM_DISK_PATTERN='^[0-9]+[KMG]$'
if ! [[ "$CONTROL_PLANE_MEMORY" =~ $MEM_DISK_PATTERN ]]; then
  echo "Error: --control-plane-memory must end in K, M, or G."; exit 1
fi
if ! [[ "$WORKER_MEMORY" =~ $MEM_DISK_PATTERN ]]; then
  echo "Error: --worker-memory must end in K, M, or G."; exit 1
fi
if ! [[ "$CONTROL_PLANE_DISK" =~ $MEM_DISK_PATTERN ]]; then
  echo "Error: --control-plane-disk must end in K, M, or G."; exit 1
fi
if ! [[ "$WORKER_DISK" =~ $MEM_DISK_PATTERN ]]; then
  echo "Error: --worker-disk must end in K, M, or G."; exit 1
fi

# Expand tilde if used in path
eval SSH_PUBLIC_KEY_PATH="$SSH_PUBLIC_KEY_PATH"
eval SSH_PRIVATE_KEY_PATH="$SSH_PRIVATE_KEY_PATH"
if [ ! -f "$SSH_PUBLIC_KEY_PATH" ]; then
    echo "Error: SSH public key file not found at $SSH_PUBLIC_KEY_PATH"
    exit 1
fi
if [ ! -f "$SSH_PRIVATE_KEY_PATH" ]; then
    echo "Error: SSH private key file not found at $SSH_PRIVATE_KEY_PATH"
    exit 1
fi

createInstance () {
    if ! multipass list | grep "$1" > /dev/null 2>&1; then
      multipass launch -n "$1" \
        --cpus "$2" \
        --memory "$3" \
        --disk "$4" \
        --cloud-init - <<EOF
users:
- name: ${USER}
  groups: sudo
  sudo: ALL=(ALL) NOPASSWD:ALL
  ssh_authorized_keys:
  - $(cat "$SSH_PUBLIC_KEY_PATH")
EOF
  fi
}

getNodeIP() {
    multipass list | grep $1 | awk '{print $3}'
}

installK3sMasterNode() {
    k3sup install --ip "$K8S_APISERVER_IP" --context "$NAME" --user "$USER" --ssh-key  "${SSH_PRIVATE_KEY_PATH}" --cluster
}

joinK3sMasterNode() {
    NODE_IP=$(getNodeIP "$1")
    k3sup join --server-ip "$K8S_APISERVER_IP" --ip "$NODE_IP" --user "$USER" --ssh-key "${SSH_PRIVATE_KEY_PATH}" --server
}
joinK3sWorkerNode() {
    NODE_IP=$(getNodeIP "$1")
    k3sup join --server-ip "$K8S_APISERVER_IP" --ip "$NODE_IP" --user "$USER" --ssh-key "${SSH_PRIVATE_KEY_PATH}"
}

for i in $(seq 1 "$CONTROL_PLANE_NODES"); do 
    createInstance "$NAME-cp$i" "$CONTROL_PLANE_CPUS" "$CONTROL_PLANE_MEMORY" "$CONTROL_PLANE_DISK"
done

for i in $(seq 1 "$WORKER_NODES"); do
    createInstance "$NAME-node$i" "$WORKER_CPUS" "$WORKER_MEMORY" "$WORKER_DISK"
done

K8S_APISERVER_IP=$(getNodeIP "${NAME}-cp1")

installK3sMasterNode "$NAME-cp1"
for i in $(seq 2 "$CONTROL_PLANE_NODES"); do
  joinK3sMasterNode "$NAME-cp$i"
done

for i in $(seq 1 "$WORKER_NODES"); do
  joinK3sWorkerNode "$NAME-node$i"
done