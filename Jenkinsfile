pipeline {
    agent any
    
    environment {
        SCANNER_HOME= tool 'Sonar'
    }

    stages {
        stage('Git checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/nilupabatawala/devopstest-updated'
            }
        }
        stage('File system scan') {
            steps {
                sh 'trivy fs --format table -o trivy-fs-report.html .'
            }
        }
        stage('Static Code Analysis') {
            steps {
                withSonarQubeEnv('Sonar-server') {
                   script {
                    sh """
                        ${SCANNER_HOME}/bin/sonar-scanner \
                        -Dsonar.projectName=fastapi \
                        -Dsonar.projectKey=fastapi \
                        -Dsonar.sources=.
                    """
                }
                }
            }
        }
           stage('Quality Gates') {
            steps {
               script {
                  waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
                }
            }
        }
    }
  }