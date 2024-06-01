pipeline {
    agent any 
    stages {
        stage('Docker') {
            agent {
                docker { image 'node:20.11.1-alpine3.19' }
            }
        }
        stage('Test') {
            steps {
                sh 'node --version'
            }
        }
    }
}
