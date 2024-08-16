pipeline {
    agent {
         docker {  image 'docker:dind'
                   label 'jenkins-agent'
                   args '--user 1000:1000 -v /my/jenkins/workdir:/var/lib/docker'
                   args '-u root -v /var/run/docker.sock:/var/run/docker.sock'
            }
    }
    
    // environment variables
    environment {
        DOCKER_CREDENTIALS_ID = 'nilupab'
      //  DOCKER_REGISTRY = 'your-docker-registry-url'
        IMAGE_NAME = 'rabbitmqapp'
        //SCANNER_HOME= tool 'sonar-scanner'
        HOME = "${env.WORKSPACE}"
    }

    stages {
         stage ('test') {
            steps {
             sh 'docker --version'
             sh 'git --version'
            }
         }

      }

}
