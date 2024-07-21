pipeline {
    agent any
    
    // environment variables
    environment {
        DOCKER_CREDENTIALS_ID = 'nilupab'
        DOCKER_REGISTRY = 'your-docker-registry-url'
        IMAGE_NAME = 'rabbitmqapp'
        //SCANNER_HOME= tool 'sonar-scanner'
    }

    stages {
        stage('Git checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/nilupabatawala/devopstest-updated'
            }
        }
    
        stage('Docker build') {
            steps {
               script {
                  echo "docker build"
                  sh 'docker build -t $DOCKER_CREDENTIALS_ID/$IMAGE_NAME:${BUILD_NUMBER} .'
                }
            }
        }

         stage('Docker Push') {  
            environment {
                DOCKER_IMAGE = $DOCKER_CREDENTIALS_ID/$IMAGE_NAME:${BUILD_NUMBER}
                // DOCKERFILE_LOCATION = "java-maven-sonar-argocd-helm-k8s/spring-boot-app/Dockerfile"
                REGISTRY_CREDENTIALS = credentials('dockerHub')
                }
            steps {
                // withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                //     sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                //     sh 'docker push $DOCKER_CREDENTIALS_ID/$IMAGE_NAME:${BUILD_NUMBER}'
                
                // }
              script {
                def dockerImage = docker.image("${DOCKER_IMAGE}")
                docker.withRegistry('https://index.docker.io/v1/', "dockerHub") {
                dockerImage.push()
            
                }


                }
        }

         stage('Update Yaml Manifests file') {  
            environment {
            GIT_REPO_NAME = "devopstest-updated"
            GIT_USER_NAME = "nilupabatawala"
            }
            steps {
                 withCredentials([string(credentialsId: 'git', variable: 'GITHUB_TOKEN')]) {
                sh '''
                    git config user.email "nilupa14@gmail.com"
                    git config user.name "Nilupa Batawala"
                    BUILD_NUMBER=${BUILD_NUMBER}
                    CURRENT_VERSION=`grep image manifests/fastapi-app.yaml | awk -F ":" '{ print $3 }'`
                    sed -i "s/$CURRENT_VERSION/${BUILD_NUMBER}/g" manifests/fastapi-app.yaml
                    git add manifests/fastapi-app.yaml
                    git commit -m "Update deployment image to version ${BUILD_NUMBER}"
                    git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
                '''
                
                }
            }
        }

      }

}
