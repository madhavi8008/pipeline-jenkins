pipeline {
    agent any
    stages {
        stage('Prepare') {
            steps {
                script {
                    // Stash the hello-world.html file
                    stash includes: 'hello-world.html', name: 'html-file'
                }
            }
        }
        stage('Install Python') {
            steps {
                script {
                    // Check if Python3 is installed, if not, install it
                    sh '''
                        if ! command -v python3 &> /dev/null
                        then
                            echo "Python3 could not be found. Installing..."
                            if [ "$(uname)" = "Linux" ]; then
                                if [ -f /etc/debian_version ]; then
                                    sudo apt-get update
                                    sudo apt-get install -y python3
                                elif [ -f /etc/redhat-release ]; then
                                    sudo yum install -y python3
                                fi
                            elif [ "$(uname)" = "Darwin" ]; then
                                brew install python3
                            fi
                        else
                            echo "Python3 is already installed."
                        fi
                    '''
                }
            }
        }
        stage('Serve') {
            steps {
                script {
                    // Create a directory for the web server if it doesn't exist
                    sh 'mkdir -p /tmp/webserver'
                    
                    // Unstash the hello-world.html file to the agent
                    unstash 'html-file'

                    // Move the file to the web server directory
                    sh 'mv hello-world.html /tmp/webserver/'

                    // Start a simple Python HTTP server to serve the file
                    // Note: Adjust the port number if needed
                    sh 'nohup python3 -m http.server 8090 --directory /tmp/webserver &'
                }
            }
        }
    }
    post {
        always {
            script {
                // Cleanup: Stop the Python HTTP server
                sh 'pkill -f "python3 -m http.server 8090"'
            }
        }
    }
}
