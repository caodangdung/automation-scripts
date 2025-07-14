#!/bin/bash

set -e

echo "✅ Cleaning up..."

sudo apt-get autoremove -y
sudo apt-get autoclean -y

echo "✅ System cleanup complete."