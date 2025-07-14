# 📦 My Automation Scripts

This repository contains my personal collection of automation scripts for installing and configuring development environments and servers. It is designed to be reusable and shareable across multiple machines, or with your team.

## 📑 Table of Contents

- [🚀 Features](#🚀-features)
- [📂 Directory Structure](#📂-directory-structure)
- [🛠️ Usage](#🛠️-usage)
- [📜 Available Scripts](#📜-available-scripts)
  - [📁 install/](#📁-install)
    - [📂 docker/](#📂-docker)
        - [install-docker.sh](#install-docker-sh)  
        - [install-docker-compose.sh](#install-docker-compose-sh)
    - [📂 node/](#📂-node)
        - [install-node.sh](#install-node-sh)  
  - [📁 configure/](#📁-configure)
    - [harden-ssh.sh](#harden-ssh.sh)
  - [📁 utils/](#📁-utils)
    - [cleanup.sh](#cleanup.sh)
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
    docker/
      install-docker.sh
      install-docker-compose.sh
    node/
      install-node.sh
  configure/
    harden-ssh.sh
  utils/
    cleanup.sh
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

#### 📂 docker/

<a id="install-docker-sh"></a>
- **install-docker.sh**  
  Installs Docker Engine and its dependencies on Ubuntu.
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/docker/install-docker.sh | bash
  ```

<a id="install-docker-compose-sh"></a>
- **install-docker-compose.sh**  
  Downloads and installs Docker Compose from the official GitHub releases.
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/install/docker/install-docker-compose.sh | bash
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

### 📁 configure/

<a id="harden-ssh.sh"></a>
- **harden-ssh.sh**  
  Hardens SSH configuration by disabling root login and password-based authentication.
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/configure/harden-ssh.sh | sudo bash
  ```

### 📁 utils/

<a id="cleanup.sh"></a>
- **cleanup.sh**  
  Removes unused packages and cleans up package caches.
  ```bash
  curl -sSL https://raw.githubusercontent.com/caodangdung/automation-scripts/main/utils/cleanup.sh | sudo bash
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