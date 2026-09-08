# 🚀 Infraestrutura Jenkins + Node.js com Vagrant

Projeto desenvolvido para criação automatizada de um ambiente de CI/CD utilizando **Vagrant**, **VirtualBox**, **Jenkins** e **Node.js**.

A infraestrutura é composta por duas máquinas virtuais Ubuntu:

- **Jenkins:** responsável pelo servidor de integração contínua.
- **Prod:** responsável pelo ambiente da aplicação Node.js.

As máquinas são provisionadas automaticamente através de scripts Shell e possuem comunicação via SSH.

---

## 🏗️ Arquitetura

```text
                Máquina Host
                   Windows
                      │
                      │ localhost:8081
                      ▼
             ┌─────────────────┐
             │   VM Jenkins    │
             │ 192.168.56.10   │
             │                 │
             │ Jenkins         │
             │ Node.js / npm   │
             └────────┬────────┘
                      │
                      │ SSH
                      ▼
             ┌─────────────────┐
             │     VM Prod     │
             │ 192.168.56.20   │
             │                 │
             │ Node.js / npm   │
             │ Aplicação       │
             └─────────────────┘
```

---

## 🛠️ Tecnologias utilizadas

- Vagrant
- VirtualBox
- Ubuntu Server
- Jenkins
- Node.js
- npm
- Git
- GitHub
- SSH
- Jest

---

## 📁 Estrutura do projeto

```text
jenkins-vm-infrastructure/
│
├── app/
│   ├── src/
│   ├── test/
│   ├── package.json
│   ├── package-lock.json
│   └── server.js
│
├── vagrant/
│   └── scripts/
│       ├── setup-jenkins.sh
│       └── setup-node.sh
│
├── .gitignore
├── Jenkinsfile
├── README.md
└── Vagrantfile
```

---

## ⚙️ Pré-requisitos

Antes de executar o projeto, é necessário possuir:

- Git
- Vagrant
- VirtualBox

---

## ▶️ Como executar o projeto

### 1. Clonar o repositório

```bash
git clone <https://github.com/leonard0antonio/jenkins-vm-infrastructure/tree/main>
```

Entre na pasta:

```bash
cd jenkins-vm-infrastructure
```

### 2. Criar as máquinas virtuais

Execute:

```bash
vagrant up
```

O Vagrant criará e provisionará as duas máquinas virtuais:

| Máquina | IP privado | Função |
|---|---|---|
| `jenkins` | `192.168.56.10` | Servidor Jenkins |
| `prod` | `192.168.56.20` | Servidor Node.js |

---

## 🖥️ Acessando as máquinas virtuais

Para acessar a VM Jenkins:

```bash
vagrant ssh jenkins
```

Para acessar a VM de produção:

```bash
vagrant ssh prod
```

Para verificar o estado das máquinas:

```bash
vagrant status
```

---

## 🔧 Jenkins

O Jenkins é instalado automaticamente na VM `jenkins` através do script:

```text
vagrant/scripts/setup-jenkins.sh
```

Após iniciar as VMs, o Jenkins pode ser acessado no navegador através de:

```text
http://localhost:8081
```

### Obter a senha inicial do Jenkins

Entre na VM:

```bash
vagrant ssh jenkins
```

Execute:

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Utilize a senha apresentada para realizar a configuração inicial do Jenkins.

---

## 🟢 Node.js

O Node.js é instalado automaticamente através do script:

```text
vagrant/scripts/setup-node.sh
```

Para validar a instalação na VM `prod`:

```bash
vagrant ssh prod
```

Execute:

```bash
node --version
npm --version
```

---

## 📦 Aplicação Node.js

A aplicação está localizada no diretório:

```text
app/
```

Na VM `prod`, ela está disponível em:

```text
/var/www/app
```

Para instalar as dependências:

```bash
cd /var/www/app
npm install
```

---

## 🧪 Testes automatizados

O projeto utiliza **Jest** para execução dos testes automatizados.

Execute:

```bash
npm test
```

Os testes validam endpoints da aplicação, incluindo:

- `GET /`
- `GET /status`
- `GET /usuarios`

---

## 🏗️ Build

Para executar o build:

```bash
npm run build
```

---

## 🔐 Comunicação SSH entre as VMs

As máquinas utilizam uma rede privada configurada pelo Vagrant.

A VM Jenkins possui o endereço:

```text
192.168.56.10
```

A VM de produção possui:

```text
192.168.56.20
```

A comunicação pode ser validada a partir da VM Jenkins:

```bash
ping -c 4 192.168.56.20
```

E através de SSH:

```bash
ssh vagrant@192.168.56.20
```

Após a configuração das chaves SSH, a VM Jenkins consegue acessar a VM `prod` sem utilização de senha.

---

## 🔄 Pipeline CI/CD

O projeto possui um `Jenkinsfile` responsável por definir as etapas do pipeline.

O fluxo implementado é:

```text
Checkout
   ↓
Install
   ↓
Test
   ↓
Build
   ↓
Deploy
```

### Checkout

Obtém o código-fonte do repositório Git.

### Install

Instala as dependências da aplicação:

```bash
npm install
```

### Test

Executa os testes automatizados:

```bash
npm test
```

### Build

Executa o processo de build:

```bash
npm run build
```

### Deploy

O Jenkins utiliza SSH para acessar a VM `prod` e executar as operações necessárias no ambiente da aplicação.

---

## 🔑 SSH utilizado pelo Jenkins

Para permitir que o serviço Jenkins acesse a VM `prod`, é utilizada uma chave SSH específica do usuário `jenkins`.

A chave privada permanece somente na VM Jenkins e **não deve ser adicionada ao repositório Git**.

A chave pública deve ser autorizada no arquivo:

```text
~/.ssh/authorized_keys
```

da VM `prod`.

> ⚠️ Nunca envie chaves privadas, senhas ou credenciais para o GitHub.

---

## 🧹 Comandos úteis do Vagrant

Verificar as VMs:

```bash
vagrant status
```

Parar as máquinas:

```bash
vagrant halt
```

Reiniciar:

```bash
vagrant reload
```

Executar novamente o provisionamento:

```bash
vagrant provision
```

Destruir as VMs:

```bash
vagrant destroy -f
```

---

## ✅ Validações realizadas

Durante o desenvolvimento foram validados:

- Criação das duas VMs pelo Vagrant
- Provisionamento do Jenkins
- Provisionamento do Node.js
- Acesso ao Jenkins pelo navegador
- Instalação das dependências com npm
- Execução dos testes automatizados
- Execução do build
- Comunicação de rede entre as VMs
- Comunicação SSH entre Jenkins e Prod
- Acesso SSH à Prod pelo usuário de serviço do Jenkins
- Versionamento das alterações com Git

---

## 👥 Colaboradores

Projeto desenvolvido em equipe como atividade prática de **DevOps**, aplicando conceitos de:

- Infrastructure as Code
- Provisionamento automatizado
- Integração contínua
- Pipeline CI/CD
- Git e GitHub
- Administração Linux
- Comunicação SSH
