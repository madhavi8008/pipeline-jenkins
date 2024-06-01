pipeline {
    agent any

    environment {
        HTML_FILE = 'hello-world.html' // Replace with your HTML file name
        LOCAL_PATH = '/tmp/' // Replace with the destination path on the Jenkins server
        PYENV_ROOT = "${WORKSPACE}/.pyenv" // Local path for pyenv installation
        PATH = "${PYENV_ROOT}/bin:${PATH}" // Add pyenv to PATH
    }

    stages {
        stage('Install pyenv and Python 3') {
            steps {
                script {
                    sh '''
                        if ! command -v pyenv &> /dev/null
                        then
                            echo "pyenv could not be found, installing..."
                            curl https://pyenv.run | bash
                            export PATH="$HOME/.pyenv/bin:$PATH"
                            eval "$(pyenv init --path)"
                            eval "$(pyenv init -)"
                            eval "$(pyenv virtualenv-init -)"
                            pyenv install 3.8.12
                            pyenv global 3.8.12
                        else
                            echo "pyenv is already installed"
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
                        nohup ${PYENV_ROOT}/shims/python3 -m http.server 82 --directory ${LOCAL_PATH} &
                    """
                }
            }
        }
    }
}
