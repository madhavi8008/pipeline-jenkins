pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Deploy') {
            steps {
                sh 'cp hello-world.html /var/local' // Replace with the actual path
            }
        }
    }
}
