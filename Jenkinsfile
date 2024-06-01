pipeline {
    agent any

    environment {
        HTML_FILE = 'hello-world.html' // Replace with your HTML file name
        LOCAL_PATH = '/tmp' // Replace with the destination path on the Jenkins server
        SERVER_PORT = 9999 // Port to run the server
        BIND_IP = '0.0.0.0' // Bind to all interfaces
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
                        echo "Copied ${HTML_FILE} to ${LOCAL_PATH}"
                        chmod 777 ${LOCAL_PATH}/${HTML_FILE}
                        
                    """
                }
            }
        }

        stage('Run HTML file on port 9999') {
            steps {
                script {
                    sh """
                        # Kill any process running on the port
                        fuser -k ${SERVER_PORT}/tcp || true

                         # Start the server with nohup and redirecting stdout/stderr to a log file
                        nohup python3 -m http.server ${SERVER_PORT} --bind ${BIND_IP} --directory ${LOCAL_PATH} > ${WORKSPACE}/server.log 2>&1 < /dev/null &
                        chmod -R 777 /var/lib/jenkins/workspace/hello-world@tmp
                        // # Start the server
                        // nohup python3 -m http.server ${SERVER_PORT} --bind ${BIND_IP} --directory ${LOCAL_PATH} > ${WORKSPACE}/server.log 2>&1 &
                        echo "Started HTTP server on port ${SERVER_PORT} serving ${LOCAL_PATH}"

                        # Verify the server is running
                        sleep 5
                        if ! netstat -tuln | grep :${SERVER_PORT}
                        then
                            echo "Failed to start HTTP server on port ${SERVER_PORT}"
                            echo "Check the server log for details: ${WORKSPACE}/server.log"
                            exit 1
                        else
                            echo "HTTP server is running on port ${SERVER_PORT}"
                        fi
                    """
                }
            }
        }
    }
    // post {
    //     always {
    //         script {
    //             // Display the server log if it exists
    //             sh """
    //                 if [ -f ${WORKSPACE}/server.log ]; then
    //                     echo "Server Log:"
    //                     cat ${WORKSPACE}/server.log
    //                 fi
    //             """
    //         }
    //     }
    // }
}
