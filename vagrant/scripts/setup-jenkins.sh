#!/usr/bin/env bash
set -e

echo "=== Atualizando pacotes ==="
sudo apt-get update -y
sudo apt-get install -y curl wget gnupg2 software-properties-common git openjdk-17-jre

echo "=== Instalando Node.js v20 ==="
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

echo "=== Instalando Jenkins ==="
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y jenkins
sudo systemctl enable --now jenkins 