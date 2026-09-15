pipeline {
    agent any

    stages {
        stage('Install') {
            steps {
                echo "Instalando dependências..."
                sh 'cd app && npm install'
            }
        }

        stage('Test') {
            steps {
                sh 'cd app && npm test'
            }
        }

        stage('Build') {
            steps {
                sh 'cd app && npm run build'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Enviando aplicação para a VM app...'
                sshagent(['app']) {
                    sh '''
                        # Compacta os arquivos ignorando a pasta node_modules
                        tar --exclude=node_modules -czf app.tar.gz -C app .

                        # Envia o arquivo para a VM prod usando scp
                        scp -o StrictHostKeyChecking=no \
                            app.tar.gz \
                            vagrant@192.168.33.20:/tmp/app.tar.gz

                        # Acessa a VM prod via SSH para descompactar e instalar dependências
                        ssh -o StrictHostKeyChecking=no vagrant@192.168.56.20 '
                            rm -rf /home/vagrant/app-prod &&
                            mkdir -p /home/vagrant/app-prod &&
                            tar -xzf /tmp/app.tar.gz -C /home/vagrant/app-prod &&
                            cd /home/vagrant/app-prod &&
                            npm install
                        '

                        # Remove o pacote compactado na máquina do Jenkins
                        rm -f app.tar.gz
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline executado com sucesso!'
        }

        failure {
            echo 'Pipeline falhou. Verifique os logs.'
        }
    }
}