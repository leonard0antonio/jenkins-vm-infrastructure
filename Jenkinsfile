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

        stage('Publish to Nexus') {
            steps {
                echo 'Enviando artefato para o Nexus...'
                script {
                    // Compacta os arquivos ignorando a pasta node_modules
                    sh 'tar --exclude=node_modules -czf app.tar.gz -C app .'

                    // Faz o upload para o repositório Raw do Nexus usando as credenciais do Jenkins
                    withCredentials([usernamePassword(credentialsId: 'nexus-cred', usernameVariable: 'NEXUS_USER', passwordVariable: 'NEXUS_PASS')]) {
                        sh '''
                            curl -v -u "${NEXUS_USER}:${NEXUS_PASS}" \
                            --upload-file app.tar.gz \
                            http://192.168.56.30:8081/repository/meu-app-repo/app.tar.gz
                        '''
                    }

                    // Remove o arquivo compactado local da máquina do Jenkins
                    sh 'rm -f app.tar.gz'
                }
            }
        }

        stage('Deploy') {
            steps {
                echo 'Baixando e implantando aplicação na VM Prod a partir do Nexus...'
                sshagent(['app']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no vagrant@192.168.56.20 '
                            rm -rf /home/vagrant/app-prod &&
                            mkdir -p /home/vagrant/app-prod &&
                            wget http://192.168.56.30:8081/repository/meu-app-repo/app.tar.gz -O /tmp/app.tar.gz &&
                            tar -xzf /tmp/app.tar.gz -C /home/vagrant/app-prod &&
                            cd /home/vagrant/app-prod &&
                            npm install
                        '
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline e Deploy via Nexus executados com sucesso!'
        }

        failure {
            echo 'Pipeline falhou. Verifique os logs.'
        }
    }
}