#!/usr/bin/env bash
set -e

echo "=== Atualizando pacotes ==="
sudo apt-get update -y
sudo apt-get install -y curl wget git

echo "=== Instalando Node.js v20 ==="
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs