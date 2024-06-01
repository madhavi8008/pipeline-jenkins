pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from your version control system
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh 'docker build -t my-simple-website .'
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container
                    sh 'docker run -d -p 82:82 --name simple-website my-simple-website'
                }
            }
        }
    }
    
    post {
        always {
            // Clean up Docker containers and images
            script {
                sh 'docker stop simple-website || true'
                sh 'docker rm simple-website || true'
                sh 'docker rmi my-simple-website || true'
            }
        }
    }
}
