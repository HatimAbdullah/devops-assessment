pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = 'docker-hub-credentials'
        DOCKER_IMAGE_NAME = 'ahmedelbdrawy/app'
        DOCKER_IMAGE_TAG = '1.1.0'
        DOCKERFILE_DIR = './sample-service'  
    }

    stages {
        stage('Build and Push Image') {
            steps {
                script {

                    
                    docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}")
                        .withRegistry('https://index.docker.io/v1/', DOCKER_HUB_CREDENTIALS) {
                            def customImage = docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}", DOCKERFILE_DIR)
                            customImage.push()
                        }
                    
                }
            }
        }
    }
}