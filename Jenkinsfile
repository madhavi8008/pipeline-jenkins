pipeline {
    agent any

     environment {
        PATH = "/usr/bin/python3:$PATH"
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

         stage('build') {
            steps {
                echo 'Preparing'
                sh 'python3 --version'
                // Other build steps
            }
        }
        
         stage('Run HTML File') {
            steps {
                sh 'python3 -m http.server 8082' // Start Python HTTP server on port 8082
            }
        }
    }
}
