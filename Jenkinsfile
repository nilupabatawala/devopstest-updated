pipeline {
    agent any
    
    // environment variables
     environment {
        DOCKER_CREDENTIALS_ID = 'nilupab'
        DOCKER_REGISTRY = 'your-docker-registry-url'
        IMAGE_NAME = 'rabbitmqapp'
        IMAGE_TAG = 'latest'
        //SCANNER_HOME= tool 'sonar-scanner'
    }

    stages {
        stage('Git checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/nilupabatawala/devopstest-updated'
            }
        }
        // stage('File system scan') {
        //     steps {
        //         sh 'touch .trivyignore'
        //         sh 'echo "node_modules >> .trivyignore "'
        //         sh 'trivy fs --format table -o trivy-fs-report.html .'
        //     }
        // }
        // stage('Static Code Analysis') {
        //     steps {
        //         withSonarQubeEnv('Sonar-server') {
        //            script {
        //             sh "${SCANNER_HOME}/bin/sonar-scanner"
        //         }
        //         }
        //     }
        // }
        // stage('Quality Gates') {
        //     steps {
        //        script {
        //           echo "QUality gate"
        //         }
        //     }
        // }

         stage('Docker build') {
            steps {
               script {
                  echo "docker build"
                  sh 'docker build -t $DOCKER_CREDENTIALS_ID/$IMAGE_NAME:$IMAGE_TAG .'
                }
            }
        }

         stage('Docker Push') {  
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                    sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                    sh 'docker push $DOCKER_CREDENTIALS_ID/$IMAGE_NAME:$IMAGE_TAG'
        }
      }
    }
  }