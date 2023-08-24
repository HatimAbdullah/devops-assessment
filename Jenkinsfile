pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'DOCKER_HUB_CREDENTIALS'
        DOCKER_IMAGE_NAME = 'ahmedelbdrawy/app'
        DOCKER_IMAGE_TAG = '1.1.0'
        DOCKERFILE_DIR = './sample-service'  
    }
   stages {
     stage('Preparation') {
       steps {
         echo "Build Preparation"
         cleanWs()
         checkout scm
       }
     }
    
     stage('Build and Push Image') {
         steps {
             script {
                 echo "Building and pushing Docker image"
                 docker.withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                         def customImage = docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}", DOCKERFILE_DIR)
                         customImage.push()
                     }
                              }
         }
     }
    
     stage('Deployment') {
     steps {
       script {
             echo "Deployment stage"
 
             configFileProvider([configFile(fileId: 'k8s-config', variable: 'config')]) {
               sh """
                 sed -i "s/VERSIONS/${DOCKER_IMAGE_TAG}/" deployment.yaml
                 kubectl apply -f deployment.yaml --kubeconfig=$config
                 """
             }
           }
         }
     }
    }
  }
