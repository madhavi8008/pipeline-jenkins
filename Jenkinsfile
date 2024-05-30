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
                sh 'cp hello-world.html /tmp' // Replace with the actual path
            }
        }
    }
}
