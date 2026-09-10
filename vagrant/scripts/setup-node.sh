#!/bin/bash

echo "=== Atualizando os pacotes ==="
apt-get update -y

echo "=== Instalando curl ==="
apt-get install -y curl

echo "=== Configurando repositorio do Node.js ==="
curl -fsSL https://deb.nodesource.com/setup_20.x | bash -

echo "=== Instalando Node.js ==="
apt-get install -y nodejs

echo "=== Verificando instalacao ==="
node --version
npm --version

echo "=== Node.js instalado com sucesso ==="

