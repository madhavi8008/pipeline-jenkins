pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Run HTML File') {
            steps {
                sh 'python -m http.server 8082' // Start Python HTTP server on port 8082
            }
        }
    }
}
