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
        stage('Install Build Tools and Python') {
            steps {
                script {
                    // Install build tools and Python3 without sudo
                    sh '''
                        if ! command -v gcc &> /dev/null
                        then
                            echo "GCC could not be found. Installing..."
                            if [ -f /etc/debian_version ]; then
                                apt-get update && apt-get install -y build-essential wget
                            elif [ -f /etc/redhat-release ]; then
                                yum groupinstall -y 'Development Tools' && yum install -y wget
                            fi
                        else
                            echo "GCC is already installed."
                        fi

                        if ! command -v python3 &> /dev/null
                        then
                            echo "Python3 could not be found. Installing locally..."
                            wget https://www.python.org/ftp/python/3.9.2/Python-3.9.2.tgz
                            tar xzf Python-3.9.2.tgz
                            cd Python-3.9.2
                            ./configure --prefix=$HOME/python3
                            make
                            make install
                            export PATH=$HOME/python3/bin:$PATH
                            cd ..
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
                    sh '''
                        if command -v python3 &> /dev/null
                        then
                            nohup python3 -m http.server 8082 --directory /tmp/webserver &
                        else
                            $HOME/python3/bin/python3 -m http.server 8082 --directory /tmp/webserver &
                        fi
                    '''
                }
            }
        }
    }
    post {
        always {
            script {
                // Cleanup: Stop the Python HTTP server
                sh 'pkill -f "python3 -m http.server 8082" || pkill -f "$HOME/python3/bin/python3 -m http.server 8080"'
            }
        }
    }
}
