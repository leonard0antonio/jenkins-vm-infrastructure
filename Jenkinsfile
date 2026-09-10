pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install') {
            steps {
                dir('app') {
                    sh 'npm install'
                }
            }
        }

        stage('Test') {
            steps {
                dir('app') {
                    sh 'npm test'
                }
            }
        }

        stage('Build') {
            steps {
                dir('app') {
                    sh 'npm run build'
                }
            }
        }

        stage('Deploy') {
            steps {
        sh '''
            tar --exclude=node_modules -czf app.tar.gz -C app .

            scp -o StrictHostKeyChecking=no \
                app.tar.gz \
                vagrant@192.168.56.20:/tmp/app.tar.gz

            ssh -o StrictHostKeyChecking=no \
                vagrant@192.168.56.20 '
                    rm -rf /home/vagrant/deploy/app &&
                    mkdir -p /home/vagrant/deploy/app &&
                    tar -xzf /tmp/app.tar.gz -C /home/vagrant/deploy/app &&
                    cd /home/vagrant/deploy/app &&
                    npm install &&
                    npm run build
                '

            rm -f app.tar.gz
        '''
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
