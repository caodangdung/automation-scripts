# 📦 My Automation Scripts

This repository contains my personal collection of automation scripts for installing and configuring development environments and servers. It is designed to be reusable and shareable across multiple machines, or with your team.

## 📑 Table of Contents

- [🚀 Features](#🚀-features)
- [📂 Directory Structure](#📂-directory-structure)
- [🛠️ Usage](#🛠️-usage)
- [📜 Available Scripts](#📜-available-scripts)
  - [📁 install/](#📁-install)
    - [📂 database/](#📂-database)
        - [install-cassandra.sh](#install-cassandra-sh)
        - [install-cloudbeaver.sh](#install-cloudbeaver-sh)
        - [install-mariadb.sh](#install-mariadb-sh)
        - [install-memcached.sh](#install-memcached-sh)
        - [install-mongodb.sh](#install-mongodb-sh)
        - [install-mysql.sh](#install-mysql-sh)
        - [install-oracle.sh](#install-oracle-sh)
        - [install-postgres.sh](#install-postgres-sh)
        - [install-redis.sh](#install-redis-sh)
        - [install-sqlserver.sh](#install-sqlserver-sh)
    - [📂 docker/](#📂-docker)
        - [install-docker.sh](#install-docker-sh)  
        - [install-docker-compose.sh](#install-docker-compose-sh)
    - [📂 nfs/](#📂-nfs)
        - [install-nfs-server.sh](#install-nfs-server-sh)
        - [install-nfs-client.sh](#install-nfs-client-sh)
    - [📂 node/](#📂-node)
        - [install-node.sh](#install-node-sh)
        - [install-node-nvm.sh](#install-node-nvm-sh)
    - [📂 k3s/](#📂-k3s)
        - [install-k3s-multipass.sh](#install-k3s-multipass-sh)
        - [install-k3sup.sh](#install-k3sup-sh)
        - [install-multipass.sh](#install-multipass-sh)
  - [📁 configure/](#📁-configure)
    - [harden-ssh.sh](#harden-ssh-sh)
  - [📁 utils/](#📁-utils)
    - [cleanup.sh](#cleanup-sh)
    - [gen-ssh-key.sh](#gen-ssh-key-sh)
- [🔒 Security Notes](#🔒-security-notes)
- [📄 License](#📄-license)
- [🤝 Contributing](#🤝-contributing)
- [🙏 Acknowledgements](#🙏-acknowledgements)

---

## 🚀 Features

✅ Easy to use  
✅ Supports Ubuntu (Debian-based) systems  
✅ Clean and well documented  
✅ Designed for security (idempotent and minimal)  
✅ MIT licensed  

---

## 📂 Directory Structure

```plaintext
automation-scripts/
  install/
    database/
      install-cassandra.sh
      install-cloudbeaver.sh
      install-mariadb.sh
      install-memcached.sh
      install-mongodb.sh
      install-mysql.sh
      install-oracle.sh
      install-postgres.sh
      install-redis.sh
      install-sqlserver.sh
    docker/
      install-docker.sh
      install-docker-compose.sh
    nfs/
      install-nfs-server.sh
      install-nfs-client.sh
    node/
      install-node.sh
      install-node-nvm.sh
    k3s/
      install-k3s-multipass.sh
      install-k3sup.sh
      install-multipass.sh
  configure/
    harden-ssh.sh
  utils/
    cleanup.sh
    gen-ssh-key.sh
  LICENSE
  README.md
```
## 🛠️ Usage

You can execute any script directly from the GitHub **raw** link, for example:

```bash
curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/install-docker.sh | bash
```

> ⚠️ **IMPORTANT:** Always review scripts before piping to `bash`. Trust, but verify!

## 📜 Available Scripts

### 📁 install/

#### 📂 database/

<a id="install-cassandra-sh"></a>
- **install-cassandra.sh**  
  Installs Cassandra:
  ```bash
  bash -i <(curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/database/install-cassandra.sh)
  ```

<a id="install-cloudbeaver-sh"></a>
- **install-cloudbeaver.sh**  
  Installs Cloudbeaver:
  ```bash
  bash -i <(curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/database/install-cloudbeaver.sh)
  ```

<a id="install-mariadb-sh"></a>
- **install-mariadb.sh**  
  Installs Mariadb:
  ```bash
  bash -i <(curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/database/install-mariadb.sh)
  ```

<a id="install-memcached-sh"></a>
- **install-memcached.sh**  
  Installs Memcached:
  ```bash
  bash -i <(curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/database/install-memcached.sh)
  ```

<a id="install-mongodb-sh"></a>
- **install-mongodb.sh**  
  Installs Mongodb:
  ```bash
  bash -i <(curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/database/install-mongodb.sh)
  ```

<a id="install-mysql-sh"></a>
- **install-mysql.sh**  
  Installs Mysql:
  ```bash
  bash -i <(curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/database/install-mysql.sh)
  ```

<a id="install-oracle-sh"></a>
- **install-oracle.sh**  
  Installs Oracle:
  ```bash
  bash -i <(curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/database/install-oracle.sh)
  ```

<a id="install-postgres-sh"></a>
- **install-postgres.sh**  
  Installs Postgres:
  ```bash
  bash -i <(curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/database/install-postgres.sh)
  ```

<a id="install-redis-sh"></a>
- **install-redis.sh**  
  Installs Redis:
  ```bash
  bash -i <(curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/database/install-redis.sh)
  ```

<a id="install-sqlserver-sh"></a>
- **install-sqlserver.sh**  
  Installs Sqlserver:
  ```bash
  bash -i <(curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/database/install-sqlserver.sh)
  ```

#### 📂 docker/

<a id="install-docker-sh"></a>
- **install-docker.sh**  
  Installs Docker Engine and its dependencies:
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/docker/install-docker.sh | bash
  ```

<a id="install-docker-compose-sh"></a>
- **install-docker-compose.sh**  
  Downloads and installs Docker Compose from the official GitHub releases:
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/docker/install-docker-compose.sh | bash
  ```

#### 📂 nfs/

<a id="install-nfs-server-sh"></a>
- **install-nfs-server.sh**  
  Installs NFS Server:
  ```bash
  bash -i <(curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/nfs/install-nfs-server.sh)
  ```
<a id="install-nfs-client-sh"></a>
- **install-nfs-client.sh**  
  Installs NFS Client:
  ```bash
  bash -i <(curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/nfs/install-nfs-client.sh)
  ```

#### 📂 node/

<a id="install-node-sh"></a>
- **install-node.sh**  
  Install the latest LTS version:
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/node/install-node.sh | bash
  ```
  Install a specific version (e.g. 18.20.2):
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/node/install-node.sh | bash -s 18.20.2
  ```
<a id="install-node-nvm-sh"></a>
- **install-node-nvm.sh**  
  Install the latest LTS version:
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/node/install-node-nvm.sh | bash
  ```
  Install a specific version (e.g. 18.20.2):

#### 📂 k3s/

<a id="install-k3s-multipass-sh"></a>
- **install-k3s-multipass.sh**
  Installs k3s inside Multipass VMs using k3sup:
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/k3s/install-k3s-multipass.sh | bash -s -- --control-plane-nodes 1 --worker-nodes 2 --name mycluster
  ```
  Or with custom resource settings, disk sizes, SSH key paths, and user:
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/k3s/install-k3s-multipass.sh | bash -s -- --control-plane-nodes 1 --worker-nodes 2 --name mycluster --control-plane-cpus 2 --control-plane-memory 2G --control-plane-disk 10G --worker-cpus 1 --worker-memory 1G --worker-disk 20G --ssh-public-key ~/.ssh/id_rsa.pub --ssh-private-key ~/.ssh/id_rsa --user ubuntu
  ```

<a id="install-k3sup-sh"></a>
- **install-k3sup.sh**
  Installs k3sup locally:
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/k3s/install-k3sup.sh | bash
  ```
  Or install to a custom path:
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/k3s/install-k3sup.sh | bash -s /usr/local/bin/k3sup
  ```

<a id="install-multipass-sh"></a>
- **install-multipass.sh**
  Installs Multipass locally:
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/k3s/install-multipass.sh | bash
  ```
  Or install a specific snap channel:
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/k3s/install-multipass.sh | bash -s candidate
  ```

### 📁 configure/

<a id="harden-ssh-sh"></a>
- **harden-ssh.sh**  
  Hardens SSH configuration by disabling root login and password-based authentication.
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/configure/harden-ssh.sh | sudo bash
  ```

### 📁 utils/

<a id="cleanup-sh"></a>
- **cleanup.sh**  
  Removes unused packages and cleans up package caches.
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/utils/cleanup.sh | sudo bash
  ```

<a id="gen-ssh-key-sh"></a>
- **gen-ssh-key.sh**  
  Generates an SSH key pair.
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/utils/gen-ssh-key.sh | bash
  ```
  Use a custom key path or email/comment:
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/utils/gen-ssh-key.sh | bash -s ~/.ssh/id_rsa_work email@example.com
  ```

## 🔒 Security Notes

- Always inspect scripts before running them with `curl | bash`.  
- These scripts target Ubuntu/Debian systems and **may** require adaptation for other distributions.  
- Feel free to fork and customize as needed.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE).

---

## 🤝 Contributing

If you’d like to contribute improvements, feel free to fork this repository and open a pull request.

---

## 🙏 Acknowledgements

Thanks to the open-source community and all contributors who help maintain best practices for server automation.