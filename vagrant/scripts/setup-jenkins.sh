#!/bin/bash

echo "=== Atualizando os pacotes ==="
apt-get update -y

echo "=== Instalando dependencias ==="
apt-get install -y curl wget fontconfig openjdk-21-jre

echo "=== Instalando Node.js ==="
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
apt-get install -y nodejs

echo "=== Verificando Node.js ==="
node --version
npm --version

echo "=== Configurando repositorio do Jenkins ==="
mkdir -p /etc/apt/keyrings

wget -O /etc/apt/keyrings/jenkins-keyring.asc \
https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key

echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" \
> /etc/apt/sources.list.d/jenkins.list

echo "=== Instalando Jenkins ==="
apt-get update -y
apt-get install -y jenkins

echo "=== Habilitando Jenkins ==="
systemctl enable jenkins
systemctl start jenkins

echo "=== Verificando Jenkins ==="
systemctl status jenkins --no-pager

echo "=== Provisionamento concluido ==="
>>>>>>> d4f8743898a165f3d2be100f680faf1c2397c790
