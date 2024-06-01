pipeline {
    agent any

    environment {
        HTML_FILE = 'hello-world.html' // Replace with your HTML file name
        LOCAL_PATH = '/tmp/' // Replace with the destination path on the Jenkins server
    }

    stages {
        stage('Install Python 3 if necessary') {
            steps {
                script {
                    sh '''
                        if ! command -v python3 &> /dev/null
                        then
                            echo "Python 3 could not be found, installing..."
                            sudo apt-get update
                            sudo apt-get install -y python3
                        else
                            echo "Python 3 is already installed"
                        fi
                    '''
                }
            }
        }

        stage('Copy HTML file to local path') {
            steps {
                script {
                    sh """
                        cp ${WORKSPACE}/${HTML_FILE} ${LOCAL_PATH}
                    """
                }
            }
        }

        stage('Run HTML file on port 82') {
            steps {
                script {
                    sh """
                        nohup python3 -m http.server 82 --directory ${LOCAL_PATH} &
                    """
                }
            }
        }
    }
}
